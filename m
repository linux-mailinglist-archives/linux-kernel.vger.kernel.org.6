Return-Path: <linux-kernel+bounces-539688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8462CA4A761
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 02:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 432CD189C986
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 01:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC2822EE4;
	Sat,  1 Mar 2025 01:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MHeGYUMT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5204A935
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 01:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740792413; cv=none; b=ZHgfH4S4X4AQ4Btp2u/qjAMeJFbRMa0sy6/hhdCBCmVtYnJyKZDum8GvNb5YON3GBsIGXFg5+dOjIwSgH7wfn0Nbd4LdIWaZBpXLHzZtpiJvR9Y/m2JjdKA/ekUqht6cGVw5N3TZwddsAY7TmqrzXnWmQmhdzL8FSxQvshykEPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740792413; c=relaxed/simple;
	bh=GJRdH7Py2r4TCQURAl8QCe4ysMucIaXY8Z8uqx8/VG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LD98aYnSV2aUS4YcA7OhtAgz1PjNOIkOaNuRgOHDs6zOd4OXlN9eTYtiBCLyb2mMtprDIsZ9w+Q/G6CuOc31Rqxv9CxuRff72pWfTo/+JR8r6rrIZi0qu7emN/uJg3pUKBxWmUnIlgqIv1KeFndoC7CQBt5h9MGKBPK7s2qj8dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MHeGYUMT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740792409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w6dnxp9WYsNQwZ9vI6v1G24aXs3uhHVto8Xb5zEf7MI=;
	b=MHeGYUMT8DYeJ2c4l/n9g/iKHIWgcSRW8NEA9t5TbLbqMyjSy87c/fF5g1KEAxr4zEBnY3
	0OMl/YEnJEpWissG1lV/X0+1LmFp7Hib45k1BE4B98Lz9NBcMgi2OKvXu/ey3Wt56g8/yX
	uJWEYD7pn8S2sxhlBkPuiYmKOUrjOQc=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-bPushaAqOKK5GspLSOQMcg-1; Fri, 28 Feb 2025 20:26:48 -0500
X-MC-Unique: bPushaAqOKK5GspLSOQMcg-1
X-Mimecast-MFC-AGG-ID: bPushaAqOKK5GspLSOQMcg_1740792407
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-86b4301c07cso1131629241.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 17:26:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740792407; x=1741397207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6dnxp9WYsNQwZ9vI6v1G24aXs3uhHVto8Xb5zEf7MI=;
        b=b/bYppTa/n3OciLR+xEaUBmUPqySNo4VqHokiKoLDbIHXR5xIz/lBwWNUiWZxXT5e4
         /9nDCoT3Bwmfs0ql/ga10UvrA2n8gC0j06Ag/09o5AyWUSN95/8KRXXhuDO0fUtJ8PD9
         rKUHEnaa4zPDiAQsWxFkzc0TVJaeW3Z0YK//yehfFAvEbHufnmodIf4FNXmGERt5a++K
         cMVTmbiQT1pXgPddcu3Ta3FwMB5UeLyeV/upnPV8L41uYSezD9UJ3B/TtJtSZxBiJRPy
         H/ymjD67bmhT7TxeeOD5rIu8REnyAmweusDTmWwmLnwUjwFJ67qcLybp+y0iZlAjEyMf
         coHg==
X-Gm-Message-State: AOJu0Yzsrqm9bxWSK2ybrVEvj7jOYWmDbisFdsea0sztrHIz4iV1raQ6
	M72T2m6JAXS9lsFiezO/tXDH6MfWVv3Idwwjya0TR9GEpKBiQ2eXGZmo3Jq87F1gdCpbcoqMTQo
	Oneb/o1AnmDAGDULoPBqdM7rhoATkScx7KM+9rLZIYdetjTPycpjBCuuX259giNVm32Uyty1WPb
	n4pTT9KuLOmgAXTnTgZiT0aRK12Cl6g9jy/6eOejgLJ2oacRI=
X-Gm-Gg: ASbGncvnp12zWUzs4kcCCeUcpRDtqVLlgcbE+KPYjQUwrjCK4jSG8PZCNYtTG4uYx+s
	Mg0w5HAKswIaVdXme/QHmEDUkh/gMrFyZM3tDE8vJ1IUfstw5U6bTiMIrMM50DyOWlZSYEH2a5Q
	==
X-Received: by 2002:a05:6122:8293:b0:520:51a4:b819 with SMTP id 71dfb90a1353d-5235b519b28mr3507236e0c.1.1740792407167;
        Fri, 28 Feb 2025 17:26:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGO3+RRkopwHC744q1bF4z/l7fKpr6okBzyltA/RQWqBy18J327LdjsIFzinZgD1ijE/BP+TkrCT/6/4YPSDv4=
X-Received: by 2002:a05:6122:8293:b0:520:51a4:b819 with SMTP id
 71dfb90a1353d-5235b519b28mr3507233e0c.1.1740792406855; Fri, 28 Feb 2025
 17:26:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4ae6d363-2f9b-5028-db1a-061b6f1e8fbe@canonical.com> <892c7de5-d257-d4d6-2bfc-62f543965cff@canonical.com>
In-Reply-To: <892c7de5-d257-d4d6-2bfc-62f543965cff@canonical.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Sat, 1 Mar 2025 09:26:35 +0800
X-Gm-Features: AQ5f1JrkB2tCsFeunXfn4giFbw2Z7oo7kEk_rkiaUrID7LrQOCtJb0ha_haUg04
Message-ID: <CAFj5m9JEDW0kLfnDhF4xNFzMTpHBH6Xpdb+XVLf73oq3vzCjQg@mail.gmail.com>
Subject: Re: [PATCH 1/1] block: fix conversion of GPT partition name to 7-bit
To: Olivier Gayot <olivier.gayot@canonical.com>
Cc: linux-kernel@vger.kernel.org, 
	Daniel Bungert <daniel.bungert@canonical.com>, linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 23, 2023 at 6:53=E2=80=AFAM Olivier Gayot
<olivier.gayot@canonical.com> wrote:
>
> The utf16_le_to_7bit function claims to, naively, convert a UTF-16
> string to a 7-bit ASCII string. By naively, we mean that it:
>  * drops the first byte of every character in the original UTF-16 string
>  * checks if all characters are printable, and otherwise replaces them
>    by exclamation mark "!".
>
> This means that theoretically, all characters outside the 7-bit ASCII
> range should be replaced by another character. Examples:
>
>  * lower-case alpha (=C9=92) 0x0252 becomes 0x52 (R)
>  * ligature OE (=C5=93) 0x0153 becomes 0x53 (S)
>  * hangul letter pieup (=E3=85=82) 0x3142 becomes 0x42 (B)
>  * upper-case gamma (=C6=94) 0x0194 becomes 0x94 (not printable) so gets
>    replaced by "!"
>
> The result of this conversion for the GPT partition name is passed to
> user-space as PARTNAME via udev, which is confusing and feels questionabl=
e.
>
> However, there is a flaw in the conversion function itself. By dropping
> one byte of each character and using isprint() to check if the remaining
> byte corresponds to a printable character, we do not actually guarantee
> that the resulting character is 7-bit ASCII.
>
> This happens because we pass 8-bit characters to isprint(), which
> in the kernel returns 1 for many values > 0x7f - as defined in ctype.c.
>
> This results in many values which should be replaced by "!" to be kept
> as-is, despite not being valid 7-bit ASCII. Examples:
>
>  * e with acute accent (=C3=A9) 0x00E9 becomes 0xE9 - kept as-is because
>    isprint(0xE9) returns 1.
>  * euro sign (=E2=82=AC) 0x20AC becomes 0xAC - kept as-is because isprint=
(0xAC)
>    returns 1.
>
> Fixed by using a mask of 7 bits instead of 8 bits before calling
> isprint.
>
> Signed-off-by: Olivier Gayot <olivier.gayot@canonical.com>
> ---
>  block/partitions/efi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block/partitions/efi.c b/block/partitions/efi.c
> index 5e9be13a56a8..7acba66eed48 100644
> --- a/block/partitions/efi.c
> +++ b/block/partitions/efi.c
> @@ -682,7 +682,7 @@ static void utf16_le_to_7bit(const __le16 *in, unsign=
ed int size, u8 *out)
>         out[size] =3D 0;
>
>         while (i < size) {
> -               u8 c =3D le16_to_cpu(in[i]) & 0xff;
> +               u8 c =3D le16_to_cpu(in[i]) & 0x7f;
>
>                 if (c && !isprint(c))
>                         c =3D '!';

Hello Olivier,

Looks like you didn't Cc linux-block maillist and Jens, can you
re-send the patch to
linux-block for review?

Thanks,
Ming



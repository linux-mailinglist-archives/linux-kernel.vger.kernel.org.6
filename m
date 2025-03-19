Return-Path: <linux-kernel+bounces-568807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F8EA69AA2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA938888176
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD6F214A6C;
	Wed, 19 Mar 2025 21:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="skQHvquQ"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83470213232
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 21:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742418679; cv=none; b=HJOQ5sAo+sbPNZSXhlQLo/f/mpa7YfZIm0mCPe2nqI/jkxwbJbaeVxJdwBhYCtfN5O3GWaN/TiRbUWBKH7BziInhBzvn0ky8qExdtVzNehmsEdVanq8WJmGVSX4MhQGMrIA8uiRzamkidDmN42nOR8Lpnrc7uKBk5vOJk6o4JN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742418679; c=relaxed/simple;
	bh=K1xeiOzI5QDbeqXJEQSjyj9DLXrpjvjxHFutWxirMvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kfdyk12K/HrQcMOvUMhfMQN4AFdUdNIDqF+fikVNXRGyEAQjD+I4hXFhQKszJK2F5RORIqAOr/bry4D3PdVN5lGTKDJ/58G2Xo8cQ/JYIjp9hnj2hYoblk2J6CYYePqNaQQrTCoUwa/NGcPwNgXFqUrKiqjFEtQmRiZo6qU7xVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=skQHvquQ; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-868da0af0fcso24650241.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742418676; x=1743023476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvlkhTWhAzJ84g1RHdy0S3etQzJbxZ8GWKau6gHnWHg=;
        b=skQHvquQHIljqZhXAeJn6vQoR4AFIaIL5RLITvYeJakG68hafFhapjcYpFSeEWcxT+
         YUwPdhUlc9pIhnhOYKDZWqEcKwqUI8wjMs+WQBIyQYHp/dwa9FOP1zmYnoS9CbsxNAhS
         HIQGm3WWEuHRV6Eq7NF9ko18QnjOK75KVz4OXnvqAc+BldB7ic/kuzSHIvSCdOAhB1up
         95QCnq/ZQcMKXwjdblnLIRFSgXivNZCs/dLbhY7MElUXTx5FFNftW4FVy7Te1MPBowZJ
         hJlK/QS0cP6GDVjgJ4osKMX47KUefc3+uAX5eUP1LgEUgUpXd7LpSdVA4dT+S8Akc52r
         PElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742418676; x=1743023476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvlkhTWhAzJ84g1RHdy0S3etQzJbxZ8GWKau6gHnWHg=;
        b=rL5fjTNlVMtB0pWFKe6w9XtM825YZ4bwIkuiYgp3qm7bQTaDrivsZF0PKbRJC8SauM
         s8e5tDQC1NI4IlkBbHqHhXLcG9pJ1dN6A6XE/a9yqW1ni0JCw3Q0xurkMCLNRpTG566E
         UjliVP5MY0MtPBiV4qDAg6++cVFh1kxCadAetVg1WQ9VLBIcaxkHu9PQkur0fDzkWFVY
         oXspo2XaiTZ4pFmLE7uEq9IcBkgKWBZOSuAL3yOn0dGm+6+n4/sCTpaOt2K8GFNyxtp9
         +x2MsbgPT5d+G67Ov8jOeH/E3mpup9/38T4c8GmGviHgjEHnx6o/K8iS9Zur4WvYJZN0
         30HA==
X-Forwarded-Encrypted: i=1; AJvYcCWWvuXvGrPXAQ10ebi4+1UPnx4nATnBOsoAZxGtYkk33bpqccvX/FLnCQzjCRnP8KRuOZkgJ5qO19HcIZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPeVZOirqkViGf9GLook62LpG1RGvFmtHfqlxvd3/aZzILq7tu
	4WogCi8HNj3WCPvsYvie8bbNqoXkEr47akI4lvnq0v85MtjeKDHIihVt6k0bXXq4Tp/w9ZMmtft
	58TlAP6rmu/+cIkDEo26EhA7kHPr3b2P1tfDf
X-Gm-Gg: ASbGncv2MxT0lCNqAQpECsiFrgbJNdcVWRyN6b1hbANUhD4tWkwXl84PRRP63u+HHx0
	FvzOC+Qj9X71fUN1cyQQA2MAcpXDIxuADQolkONFh0UOFeETpop9YJv74IvJ7P39USnGhQS9/mj
	sTUnsTZ7SWyWA7SBXo58kMADB2ztzsQUxBVgJT4iVEEXk/rdISL6MvPKA=
X-Google-Smtp-Source: AGHT+IG2d+8g4IUkmFtoj3fmX44ifjbLGO5wXGctt+Jqz4ODulKjbhb9daWIwSytvDrBuPXKFP8u73NR9yD8Vp49HwE=
X-Received: by 2002:a05:6102:5488:b0:4b2:c391:7d16 with SMTP id
 ada2fe7eead31-4c4fcd4b4e4mr773647137.7.1742418676277; Wed, 19 Mar 2025
 14:11:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319163341.2123-2-thorsten.blum@linux.dev>
In-Reply-To: <20250319163341.2123-2-thorsten.blum@linux.dev>
From: Justin Stitt <justinstitt@google.com>
Date: Wed, 19 Mar 2025 14:11:04 -0700
X-Gm-Features: AQ5f1JoN2uPsFw29iHN393K75wq6oD6Cg3O8Y2bxqAO1B28vC7GlbD6DEjlXh8k
Message-ID: <CAFhGd8rH1PcjjRyKzaC9CgvFgA4_uEwvsCq-4v98bmVbqi=o2A@mail.gmail.com>
Subject: Re: [PATCH] kdb: Remove optional size arguments from strscpy() calls
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <danielt@kernel.org>, 
	Douglas Anderson <dianders@chromium.org>, Arnd Bergmann <arnd@arndb.de>, 
	Daniel Thompson <daniel.thompson@linaro.org>, kgdb-bugreport@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 9:35=E2=80=AFAM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> If the destination buffer has a fixed length, strscpy() automatically
> determines the size of the destination buffer using sizeof() if the
> argument is omitted. This makes the explicit sizeof() unnecessary.
>
> Furthermore, CMD_BUFLEN is equal to sizeof(kdb_prompt_str) and can also
> be removed. Remove them to shorten and simplify the code.
>
> No functional changes intended.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  kernel/debug/kdb/kdb_io.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> index 6a77f1c779c4..9b11b10b120c 100644
> --- a/kernel/debug/kdb/kdb_io.c
> +++ b/kernel/debug/kdb/kdb_io.c
> @@ -334,7 +334,7 @@ static char *kdb_read(char *buffer, size_t bufsize)
>                 *cp =3D '\0';
>                 p_tmp =3D strrchr(buffer, ' ');
>                 p_tmp =3D (p_tmp ? p_tmp + 1 : buffer);
> -               strscpy(tmpbuffer, p_tmp, sizeof(tmpbuffer));
> +               strscpy(tmpbuffer, p_tmp);
>                 *cp =3D tmp;
>
>                 len =3D strlen(tmpbuffer);
> @@ -452,7 +452,7 @@ static char *kdb_read(char *buffer, size_t bufsize)
>  char *kdb_getstr(char *buffer, size_t bufsize, const char *prompt)
>  {
>         if (prompt && kdb_prompt_str !=3D prompt)
> -               strscpy(kdb_prompt_str, prompt, CMD_BUFLEN);
> +               strscpy(kdb_prompt_str, prompt);
>         kdb_printf("%s", kdb_prompt_str);
>         kdb_nextline =3D 1;       /* Prompt and input resets line number =
*/
>         return kdb_read(buffer, bufsize);

This matches the pattern of replacements I've done in the past, all looks g=
ood.

Reviewed-by: Justin Stitt <justinstitt@google.com>

Justin


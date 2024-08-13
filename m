Return-Path: <linux-kernel+bounces-285495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C31950E2A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 22:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91C8AB21E8E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 20:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DEF1A7066;
	Tue, 13 Aug 2024 20:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="Wzx/Fm+N"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61A91A7049
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 20:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723582320; cv=none; b=YgQrYx8i4pRElNuRjgigRrTgWmkukH4Om4ZUtNC0YTMX2AJeUpOGuPckr86wZKwyPxDh/BhW36s1qwOsftlqtLPKF+PcAZ1Xjb2e5o2lB5ttkAVStqoyktrigb0QOVfEkSzCqk/MFZcIheZEV12gJAXveWi+/oJtkUr/c8PBZLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723582320; c=relaxed/simple;
	bh=cmv3jCkqoCAwMyBNCaM1MQO2iHcsMYHlaOedlFRfJgo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Rj8nH6eqGAWg9qF6Caldk6i+c7Asmt6fuFwNzZFGvCoRyhuF5S/JQeoKrEpYPYxgwZQOMXJ0+Kta8Fo+d72zKJEDDbGXswx+BYpurs5k7j/l6fTfibHr9IQRf8Pn3mHkQ1AeWrfQzSeNpuPLJJ05fhHQNP69zHYNGbFzL81XMrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=Wzx/Fm+N; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3683329f787so3071964f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 13:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1723582317; x=1724187117; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITFAVy6a5FhNoiR85sqOnTNosoSnjit+2yLLh6uoiaw=;
        b=Wzx/Fm+NgjvjyPnchxuOsqux7Dv4eEXvGa1Wr+A2RQlg15C0Er46mHnAG/7pysASqO
         IsIQemb54dTIeI9Ar1WfY/9SVnlsZeklrEYGlE31WzhmdSSzkPG4XENEjjRYfVJcIUTI
         L5vnjaU/V2H5IqtXaGE6Bpld/V04qGuvXORApaHwZmUGsXXA/BxfIT3Lh10SuBiBtEK5
         jPMorPj0iTF5Zr7G2FqOPZLgMnL6veQ+adH1yVJOosDpIL+ar4URQUF8F5lJ56o/X0vB
         Fx84T2da3FJDSm3M/isQGj6kd+Le6Sb9EigMjnxSNt6ro5vZr8jF10a/tHQaGc4PJGnu
         Bexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723582317; x=1724187117;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ITFAVy6a5FhNoiR85sqOnTNosoSnjit+2yLLh6uoiaw=;
        b=xAJDKCWbRORdy8EpfAyqj2D1gHmYOfLWwYXDtk0XMkm1b76viz+U0FISTA9qiMnr3/
         lTC9V2bpg6bzTwmOi3LJb0EJGSy4pe7TU6wIpUzR4lh8XysuZxeVo+Uebziq9zPeYcYK
         bY+uo9YSycdOL/79d2USF6a+F7vy2sgexvC37HSI0KASP832wYYrug1EzxnU7BWYFJ92
         Ms3E6Yo5H+d0/gSHiCWyx3ZzYYGBU77n54Uy7cXClYPHcX+IBO2EW5SMWiPtPogsQqKk
         AjCR0FSivHF00RcMc8hgyalmyey2NJfkOp7ws7+hFal6/XxpqLRYc5Ki4wAi6SRaekbw
         xYFA==
X-Forwarded-Encrypted: i=1; AJvYcCVuUi4C9feuiQQHDoie7G8gU2TXrDyVPhMqLrpHSYwFfPSxndxTzewRKPLLWKGE8vkU7AJmxkRQjgOA0VPLdDrXvoh/nRq7cu4uUkDt
X-Gm-Message-State: AOJu0YwqZ7l2if7RQh/+aAjxXo9PasOsc85Xo0quEUIFYcTKVeFf3RWO
	dhV2mYd0sGenv5Th8cJsw/of2unBNHy0FOWSFmvYMCoP2XeeG4rQLAMvZfJURXo=
X-Google-Smtp-Source: AGHT+IF3ZyaCu+D/RlQe8lRsk2nG1qGO8dy23aAp35L//F63pzsttV2Ot6rpBAkj0m+V8dNCw5//qg==
X-Received: by 2002:a5d:64e7:0:b0:368:71bc:2b0c with SMTP id ffacd0b85a97d-3717774a2f2mr515714f8f.10.1723582316880;
        Tue, 13 Aug 2024 13:51:56 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:a92:ee01:80be:a0fb:1808:f06e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4ebd2bb4sm11395330f8f.91.2024.08.13.13.51.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2024 13:51:56 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] bpf: Annotate struct bpf_cand_cache with __counted_by()
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <CAADnVQKw5x6sTwj62p4vxSqtjdisHEKhtKdPp_zK4t7rtDuWhQ@mail.gmail.com>
Date: Tue, 13 Aug 2024 22:51:44 +0200
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 Eddy Z <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>,
 Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 linux-hardening@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <968A8194-61C0-4F9A-ADB6-8A6BB57E2A57@toblux.com>
References: <20240813151752.95161-2-thorsten.blum@toblux.com>
 <CAADnVQKEgG5bXvLMLYupAZO6xahWHU7mc06KFfseNoYUvoJbRQ@mail.gmail.com>
 <2A7DB1E6-4CCE-446E-B6F1-4A99D3F87B57@toblux.com>
 <CAADnVQKw5x6sTwj62p4vxSqtjdisHEKhtKdPp_zK4t7rtDuWhQ@mail.gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
X-Mailer: Apple Mail (2.3774.600.62)

On 13. Aug 2024, at 20:57, Alexei Starovoitov =
<alexei.starovoitov@gmail.com> wrote:
> On Tue, Aug 13, 2024 at 10:59=E2=80=AFAM Thorsten Blum =
<thorsten.blum@toblux.com> wrote:
>> On 13. Aug 2024, at 18:28, Alexei Starovoitov =
<alexei.starovoitov@gmail.com> wrote:
>>> On Tue, Aug 13, 2024 at 8:19=E2=80=AFAM Thorsten Blum =
<thorsten.blum@toblux.com> wrote:
>>>>=20
>>>> Add the __counted_by compiler attribute to the flexible array =
member
>>>> cands to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
>>>> CONFIG_FORTIFY_SOURCE.
>>>>=20
>>>> Increment cnt before adding a new struct to the cands array.
>>>=20
>>> why? What happens otherwise?
>>=20
>> If you try to access cands->cands[cands->cnt] without incrementing
>> cands->cnt first, you're essentially accessing the array out of =
bounds
>> which will fail during runtime.
>=20
> What kind of error/warn do you see ?
> Is it runtime or compile time?

I get a runtime error with Clang 18 [3].

> Is this the only place?

I think so.

> what about:
>       new_cands =3D kmemdup(cands, sizeof_cands(cands->cnt), =
GFP_KERNEL);
>=20
> cnt field gets copied with other fields.
> Can compiler/runtime catch that?

I think this is ok and there's nothing to catch.

> You can read more about it at [1] and [2].
>>=20
>>> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
>>>> ---
>>>> kernel/bpf/btf.c | 6 +++---
>>>> 1 file changed, 3 insertions(+), 3 deletions(-)
>>>>=20
>>>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>>>> index 520f49f422fe..42bc70a56fcd 100644
>>>> --- a/kernel/bpf/btf.c
>>>> +++ b/kernel/bpf/btf.c
>>>> @@ -7240,7 +7240,7 @@ struct bpf_cand_cache {
>>>>      struct {
>>>>              const struct btf *btf;
>>>>              u32 id;
>>>> -       } cands[];
>>>> +       } cands[] __counted_by(cnt);
>>>> };
>>>>=20
>>>> static DEFINE_MUTEX(cand_cache_mutex);
>>>> @@ -8784,9 +8784,9 @@ bpf_core_add_cands(struct bpf_cand_cache =
*cands, const struct btf *targ_btf,
>>>>              memcpy(new_cands, cands, sizeof_cands(cands->cnt));
>>>>              bpf_free_cands(cands);
>>>>              cands =3D new_cands;
>>>> -               cands->cands[cands->cnt].btf =3D targ_btf;
>>>> -               cands->cands[cands->cnt].id =3D i;
>>>>              cands->cnt++;
>>>> +               cands->cands[cands->cnt - 1].btf =3D targ_btf;
>>>> +               cands->cands[cands->cnt - 1].id =3D i;
>>>>      }
>>>>      return cands;
>>>> }
>>>> --
>>>> 2.46.0
>>>>=20
>>=20
>> [1] =
https://opensource.googleblog.com/2024/07/bounds-checking-flexible-array-m=
embers.html
>> [2] =
https://embeddedor.com/blog/2024/06/18/how-to-use-the-new-counted_by-attri=
bute-in-c-and-linux/

[3] https://godbolt.org/z/cKee95777=


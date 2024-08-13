Return-Path: <linux-kernel+bounces-285309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E39D950BEA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 20:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F002F1F283B1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 18:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772DC1A38FC;
	Tue, 13 Aug 2024 17:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="vExC26ZU"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AC31A38D5
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 17:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723571981; cv=none; b=pVX7ED3uQDxHJ42eTMoMej91Cp9PXRy4Wma8UxpTR8k/vnSTC4NGpuV9yf3b9H/mbQLc8ALJzMi/MrGqiRGmjCGOP5YUzMbTmY7MtfcF/E6ht1eiLrJZYGtI/7bfF9g05gb2hd18GIDAIeo3rMiCqV3dj0aaSRsZDcj8ggWJ5eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723571981; c=relaxed/simple;
	bh=1D3aBq+76dfV3NuMMTICVwtmTkz//c6+wX/Vqv82420=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=FWUe7Z/cItRViRX80Tu35dxV3Jv2I/iB34tom4EDnvlxiafrFgCEWjcpUch4mymU603Y9rAaz1EVsBv2iwty8t86gaV/HKaRoWE2fAQxsWIC3xWD7z0ivHduOsdG1qJ8HQRIwX22tP0pb02dvYVGUeAB+LP8q4PczeFETwAsLlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=vExC26ZU; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7b2dbd81e3so724931066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1723571978; x=1724176778; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fz0h1N/CKA3fHj12ow4qN56OoJaUyvUMXhRJFJBFv9g=;
        b=vExC26ZUeGFlWXO+pAqX+yRgHf5qUqhxxdG2apYEZQMy5XOCAqcgiRzv8UmCUdOycn
         Ika6FPVb3rvlKwA1ioA1V57QJWM5ocB6kKLo3GZBOytrNu79iBI+ttItdu1doWoCx4RP
         ZZQ8+JrcFBYhQ7FLXxcC74YfqVG7Ag038xAhlKeVqPhxKzWifpjn5BVGdppWwyGqiJfE
         Nrb5M90t0np7vFRhBdEN+pe7nx6dM7gKfAwoxhzeXIL+XNx/J5k2fimGyPs3tgu96XVg
         bFUUbax4/jSdgbw7roDUvosUqksDUuXaOAVQMAiUlLDHGw3ZyUOPw1DNkvUUCtOXxDLi
         vK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723571978; x=1724176778;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fz0h1N/CKA3fHj12ow4qN56OoJaUyvUMXhRJFJBFv9g=;
        b=qUP/lQ8e1MxsYbuX0JsAGWkI6i/7ctnb0/DxI+YcK5AJxaWSQAQOP58ANgxozk2FrM
         uKDkcgJjyOoe93focjJQJQ9IWwByQBAYFNomx6KDDdIFod0Oad6XztKKrmNExuo5sW8W
         WE1G5LCSh+AcXqyXw6mJ+kQ7hwEyXUFmT/Ns9fjdJgesMQ3Y3yTcW8VTvuT1ASUGufv1
         C3LDcvJNZnOZCgyUpAWcLqV66y4Dq9TI+1dGx2tqu/cO8cpqSnZBzt7T5OcpXk18Qw/U
         iaHAEJyzWwmHqG4ViKVlE0TgZ32lHpdQwkTvu9EJpRWFMZabB5uFn3+xNWdF+MHnEZPN
         g4Aw==
X-Forwarded-Encrypted: i=1; AJvYcCVoirnJrlUvw8yHsADT78UsoSfdmxy9Dxhrt/ZVazxQ2AzNcXStYDmoUfTsQeNpC5qF1hl4aIQ1DGiiLLk4VjUbLiQxUljiyPQWXspz
X-Gm-Message-State: AOJu0YzcdUJU+mqxZo62ywfPxWX2G9l2p5c1l9mlCWM5VUiLXmXx6ovC
	qo60C4u53JjcaNEyF8YLMrVZfsrijvy1oZzopzMS4bZouNKBI9hVbS8mLvt36/Y=
X-Google-Smtp-Source: AGHT+IHvT1d9KDa22miJHX6Og5kQRd7CLcIk5kV1JH9fciPcel8AmUjrwBIuaOctOR9AlHNT4yM1QQ==
X-Received: by 2002:a17:907:f186:b0:a7a:acae:340e with SMTP id a640c23a62f3a-a8366d444cfmr10573566b.26.1723571977503;
        Tue, 13 Aug 2024 10:59:37 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:a92:ee01:80be:a0fb:1808:f06e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3fa43f9sm88343866b.53.2024.08.13.10.59.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2024 10:59:37 -0700 (PDT)
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
In-Reply-To: <CAADnVQKEgG5bXvLMLYupAZO6xahWHU7mc06KFfseNoYUvoJbRQ@mail.gmail.com>
Date: Tue, 13 Aug 2024 19:59:25 +0200
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
Message-Id: <2A7DB1E6-4CCE-446E-B6F1-4A99D3F87B57@toblux.com>
References: <20240813151752.95161-2-thorsten.blum@toblux.com>
 <CAADnVQKEgG5bXvLMLYupAZO6xahWHU7mc06KFfseNoYUvoJbRQ@mail.gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
X-Mailer: Apple Mail (2.3774.600.62)

On 13. Aug 2024, at 18:28, Alexei Starovoitov =
<alexei.starovoitov@gmail.com> wrote:
> On Tue, Aug 13, 2024 at 8:19=E2=80=AFAM Thorsten Blum =
<thorsten.blum@toblux.com> wrote:
>>=20
>> Add the __counted_by compiler attribute to the flexible array member
>> cands to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
>> CONFIG_FORTIFY_SOURCE.
>>=20
>> Increment cnt before adding a new struct to the cands array.
>=20
> why? What happens otherwise?

If you try to access cands->cands[cands->cnt] without incrementing
cands->cnt first, you're essentially accessing the array out of bounds
which will fail during runtime.

You can read more about it at [1] and [2].

> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
>> ---
>> kernel/bpf/btf.c | 6 +++---
>> 1 file changed, 3 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 520f49f422fe..42bc70a56fcd 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -7240,7 +7240,7 @@ struct bpf_cand_cache {
>>        struct {
>>                const struct btf *btf;
>>                u32 id;
>> -       } cands[];
>> +       } cands[] __counted_by(cnt);
>> };
>>=20
>> static DEFINE_MUTEX(cand_cache_mutex);
>> @@ -8784,9 +8784,9 @@ bpf_core_add_cands(struct bpf_cand_cache =
*cands, const struct btf *targ_btf,
>>                memcpy(new_cands, cands, sizeof_cands(cands->cnt));
>>                bpf_free_cands(cands);
>>                cands =3D new_cands;
>> -               cands->cands[cands->cnt].btf =3D targ_btf;
>> -               cands->cands[cands->cnt].id =3D i;
>>                cands->cnt++;
>> +               cands->cands[cands->cnt - 1].btf =3D targ_btf;
>> +               cands->cands[cands->cnt - 1].id =3D i;
>>        }
>>        return cands;
>> }
>> --
>> 2.46.0
>>=20

[1] =
https://opensource.googleblog.com/2024/07/bounds-checking-flexible-array-m=
embers.html
[2] =
https://embeddedor.com/blog/2024/06/18/how-to-use-the-new-counted_by-attri=
bute-in-c-and-linux/=


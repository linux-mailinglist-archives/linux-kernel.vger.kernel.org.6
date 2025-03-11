Return-Path: <linux-kernel+bounces-555380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4EDA5B6A9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 03:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B313C7A410A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 02:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AB91E3DFA;
	Tue, 11 Mar 2025 02:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijnz1YSt"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F511DF26B
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 02:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741660066; cv=none; b=mIv0UbhI66MLwbS9X32vkFNXgJJPL1YBHHCFLiQs2MBdFhkU8TAeMxmqZehozRd8LZt3/8uyb5GNrJhvpqGQpzBWnGu69n7qP281jSeGYpWtGwhVHsdWF67kPmSXBiBUpRqh/LI+NOuIRby6wTmjK8Rm+KhaAF91p6f+Y+Wa5sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741660066; c=relaxed/simple;
	bh=IB1CVj8+5MyBatQbKnkkGxjk3+o4gGMY3Q5dxL6vGx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fOh+ENV/mT/0J6K94t9GyFui7KV6DIYEJ6bMt0+zeqbSKxp2EB3aO7j+UWzwJf20EJRkJS4GPbWjPyVgZbC839lbronBNzSIQTzByDbYU5bFx5MmNHIVlUOXn4KAbLa0IcwLGlPmuDb4C2LG8oQ072pXKYA8HFVQR3EpeaKqNJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijnz1YSt; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-86d6fd581f4so748361241.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 19:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741660063; x=1742264863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxNqfzIJOq+aes44VAuh3ND6XVrERi5tX1yWJumykVc=;
        b=ijnz1YSt0lejjxy5hm0Viz4wyJGi/GgZWBsN9tNPS78T+Y6f5U/+RpoHtH8x+Vs/1a
         98WnKhgjTqjR/C9jfxlabM3SiiVWiMmoCeqQS4uCC45KwNIGwtO1Cry2/LWbJbAKuYts
         snRuZPPSN+7cIZpPJ1ellkqq2r4WaQZpsAA6I5SxdUd4fXflHpd7a+JSAr2EhdArT+5y
         PoJhqBBCahtXKCvorkyX8WwLkc62PCCz03Us2YP+sTh9RSIB97o13JYZ1UQoQ8GEo3lL
         7zWFIJwX34YNfOFD58PQtY7Pu30vfd2V3QDmNM99cSbBTHBA1s2O4UbsJaR60LqtHu4T
         2DfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741660063; x=1742264863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxNqfzIJOq+aes44VAuh3ND6XVrERi5tX1yWJumykVc=;
        b=dG8K9OCr1ZbZcKBA1x0x9z9fhz/Sw/DmrBkIPcxfMPzj/RN6l/mTFYk59tYOMWba+1
         rXitOhISsy0s7dUpZkO3wJlgD/5OXCTJd6bK8Wm0ouN2H/DAiqdjOKg+YeNfvCjy78c3
         hVI4sCxPVaw6hKuaRDjgLAbf4Ke8TnkusY3569RxNOEOMUTxtinhcl6A0pex4DvWYpdL
         WZNLwaGv/u1kjVD5dKHUR5rqysyfpYwRwjjIJCoXHJrZFHWAitbrtGYGWuJqLpp5XBd8
         GkyfNFxUzR4xPEm5eflsBIr22jipaOAGpghTeAfUiW0ydz2E1/CE9z1+wcPwW3t3A8hZ
         hYfg==
X-Gm-Message-State: AOJu0Yyd5sqK6tvYNLxFUC4b64q7mqjGFXa8i+fmT9c38jUcsndsPm15
	Q4zBPF7SJF/EJhKIJ2DmNpvHCqAocOzvE9wt43ZG5aBqpIZre8fmAEg0k442UAUXvgmQm8nZ1mN
	R02tqtKGvuQd1W3jnDCQAmlg/gjg=
X-Gm-Gg: ASbGncsXS/BrooipffOflEfNds3KaPQoSs+JJ70QCYOIPFfiy4rAZ1bw0cx0v/5mR53
	w6wBaS/8xgTBp7D4stxhl9hFp68IVr7o0/C06x9eKCBfGu5xkN32HT79dGlt9rlCaOMlp1oeL2v
	Z3VowFEksu34B121mn2NGztXambXJ3DKrDwxjBdgyWpiO7zSzhFQUabbOI2n4=
X-Google-Smtp-Source: AGHT+IG44geEMd0Z6SABW33WxFehbT6i/WdOyVfr4nc5G+zHM4c/PKakIo/IjEflXjSp6/1T6K8T3kBOaH/9O5k/D1k=
X-Received: by 2002:a05:6102:e10:b0:4bb:baa0:370b with SMTP id
 ada2fe7eead31-4c34ddb2f0fmr1009145137.7.1741660062740; Mon, 10 Mar 2025
 19:27:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310120318.2124-1-arbn@yandex-team.com>
In-Reply-To: <20250310120318.2124-1-arbn@yandex-team.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Mon, 10 Mar 2025 19:27:31 -0700
X-Gm-Features: AQ5f1JonvmzKODfnS3VtcEwv6mX0Gms85-MMFdGxuU8lY-5TIICcfA8gPgKEOBg
Message-ID: <CAM_iQpWewprQzQgMWk0yMr=LCFUCGztJ4+G-NFt8gqe81XuUcg@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] KSTATE: a mechanism to migrate some part of the
 kernel state across kexec
To: Andrey Ryabinin <arbn@yandex-team.com>
Cc: linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>, 
	James Gowans <jgowans@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, 
	Pratyush Yadav <ptyadav@amazon.de>, Jason Gunthorpe <jgg@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrey,

On Mon, Mar 10, 2025 at 5:04=E2=80=AFAM Andrey Ryabinin <arbn@yandex-team.c=
om> wrote:
>     Each driver/subsystem has to solve this problem in their own way.
>     Also if we use fdt properties for individual fields, that might be wa=
stefull
>     in terms of used memory, as these properties use strings as keys.
>
>    While with KSTATE solves the same problem in more elegant way, with th=
is:
>         struct kstate_description a_state =3D {
>                 .name =3D "a_struct",
>                 .version_id =3D 1,
>                 .id =3D KSTATE_TEST_ID,
>                 .state_list =3D LIST_HEAD_INIT(test_state.state_list),
>                 .fields =3D (const struct kstate_field[]) {
>                         KSTATE_BASE_TYPE(i, struct a, int),
>                         KSTATE_BASE_TYPE(s, struct a, char [10]),
>                         KSTATE_POINTER(p_ulong, struct a),
>                         KSTATE_PAGE(page, struct a),
>                         KSTATE_END_OF_LIST()
>                 },
>         };

Hmm, this still requires manual efforts to implement this, so potentially
a lot of work given how many drivers we have in-tree.

And those KSTATE_* stuffs look a lot similar to BTF:
https://docs.kernel.org/bpf/btf.html

So, any possibility to reuse BTF here? Note, BTF is automatically
generated by pahole, no manual effort is required.

Regards,
Cong Wang


Return-Path: <linux-kernel+bounces-556091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11760A5C0FB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C0691790F7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98E825BAA0;
	Tue, 11 Mar 2025 12:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgZmrIA/"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BE625A333
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741695559; cv=none; b=TR9oUM4q0sYfz7529mnaCkoAMfQXn3e8/azIzjJUCLtPo7pkjagug19Qux4mLoCQwuRrWZcQl/Es3wBugrmeVqhGUTFJ8cWNCK/C0shtwO0Z20QTEWqcZ4zucgqvQPDPWClBTEAT37QBnqIZsONFvo+iSHb7bSG/PPV+MqWyqa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741695559; c=relaxed/simple;
	bh=Sr06KeKxyQ+IPj7DnSLod1tmtyl7tAXPjqMKObaBApQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ARNLSshsp4GevDhIS5eq5g/jOcIbQYvY+5XA0IAwLc9lSFZLcLS1G+Ejb+Gnz8DX/cB5UymK1NPhDaZkEA74UR+UKkiNvzleJJJ9CfxpEO57KT0MGacLiXiYoGy4AVRGUhq3J2LbCto7NPTnc03w8H4opXbaLHx5uB+pDAQx348=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgZmrIA/; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39123d2eb7fso397390f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 05:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741695555; x=1742300355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMdqx5IAy5RwkV48z9EOvdZc6wlr4q4CS/HOkuwTfFI=;
        b=jgZmrIA/+6iLhGCoXJ/KzYQ/m9S13EfX9aN1bQdB8O93Y53Li7MdzpZ8+nJ1w4lo1w
         NrJWvi4jDU3+A/VIsyaseclEzWEwkqSLW8WrUdcyc6tUshtOWNa8eCVVMpVy+mkamINy
         q3sh7VNoHBrtC/qPfJpK90liFuhOZ0kYq1wm65Xowus5CA90+M/H4L8dd9huH+W+VyeE
         F05Autvw/HPqTdrdU4UKcAGrqHzcNWmwkg6eooX+0tPJcg6A7cJYoca9sq4DWeAysdX/
         +ufYKw5dXb++kbRndSNNW/xGfMNR+Fyqm39P8mSZYJ/F5cpb1sUGs5LebUNaDJw+xz8Y
         ax3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741695555; x=1742300355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uMdqx5IAy5RwkV48z9EOvdZc6wlr4q4CS/HOkuwTfFI=;
        b=ucn0rUq6BT+gki2tvWWidEDmDd6YhKiDhOZo21KobjzoytOzzr0higdG3vNlXuIoTX
         IaxOEn+S9z8npBBTX2d67LNV3la8wv0P/dbgHyyIl5rGmGzb4S7mxd64cq4naUGLs8cn
         7J2D+2Av98hifYwZXoIimHKIIF1Cb71Fh5dW1lK73Vqm+VoUYEUfE9BkAfuI67iFEtZD
         OeoNsA9UtVdzyHEkw71GjBtb2z2aP++ja4NpGQrVLzyG7UccGNPKrq2mu4xCMBjABqlw
         0HC7tApmH+lbeRXyhW0hkAjNXNQG8RAhAaw91NMdP0BvVuIoJ5OeQHJu6fY9o/oVl+R/
         azdw==
X-Forwarded-Encrypted: i=1; AJvYcCV/ycS+/r059Iv7xm0PmzXqtrLzKyvpFdf1wG8P0GjF511tMp8J5HNve/toMxtSXl2U3lHod40bf6yA9I4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFzz2IdzyDC3Il7fmC86DRTG39yAbWD1uBtA7wAIjcH5/nWvvi
	UYuGeYosjXRVai0tN1lfK8ZqUVYu1e3w4LwJReUGNaL7TdvMotM0iBzruF7ENNf+A/rReQlLRBI
	BcoDF44BB3hf3gK/Un8pG7aC2gCU=
X-Gm-Gg: ASbGncvTw7zyRXWqEfi3FVX+Aamx+hdkxKVntiHpm+vqMqCHUsbjkF56QmiQBfxFkdT
	iGhTkxIU5wW0mhxUwTLewjFvIch6A4twW7AbOxMFhUE9/TyWQzeyRmtiaXe7p7XYNoyDBmfzqIy
	YTUFqSijb8mzIE5r08U9yHHvSHZB2QZxbQ9kp5epO9SfVJGLt1c/o7L4+b
X-Google-Smtp-Source: AGHT+IGz6yyYStQwXScQVA2NmPU6agIBdpm9T+QAnp5+AsC3//dJ8lHkSh1/zt7aSeT4AfjpaJGHgRPiVMRftVNRVSw=
X-Received: by 2002:a5d:5f90:0:b0:38a:615c:8266 with SMTP id
 ffacd0b85a97d-3913bb2fac5mr4151795f8f.1.1741695555258; Tue, 11 Mar 2025
 05:19:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310120318.2124-1-arbn@yandex-team.com> <CAM_iQpWewprQzQgMWk0yMr=LCFUCGztJ4+G-NFt8gqe81XuUcg@mail.gmail.com>
In-Reply-To: <CAM_iQpWewprQzQgMWk0yMr=LCFUCGztJ4+G-NFt8gqe81XuUcg@mail.gmail.com>
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Date: Tue, 11 Mar 2025 13:19:02 +0100
X-Gm-Features: AQ5f1Jp-4WIS7zgwSRZD9fIZPznfBSfecmUex3m3QdtGpEpLMxmRqOA6DAx82aU
Message-ID: <CAPAsAGyOcyi1PLK_mjdf9STX4HOxNnBU8t3d20fSS3QO+znwNg@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] KSTATE: a mechanism to migrate some part of the
 kernel state across kexec
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Andrey Ryabinin <arbn@yandex-team.com>, linux-kernel@vger.kernel.org, 
	Alexander Graf <graf@amazon.com>, James Gowans <jgowans@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, 
	Pratyush Yadav <ptyadav@amazon.de>, Jason Gunthorpe <jgg@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 3:28=E2=80=AFAM Cong Wang <xiyou.wangcong@gmail.com=
> wrote:
>
> Hi Andrey,
>
> On Mon, Mar 10, 2025 at 5:04=E2=80=AFAM Andrey Ryabinin <arbn@yandex-team=
.com> wrote:
> >     Each driver/subsystem has to solve this problem in their own way.
> >     Also if we use fdt properties for individual fields, that might be =
wastefull
> >     in terms of used memory, as these properties use strings as keys.
> >
> >    While with KSTATE solves the same problem in more elegant way, with =
this:
> >         struct kstate_description a_state =3D {
> >                 .name =3D "a_struct",
> >                 .version_id =3D 1,
> >                 .id =3D KSTATE_TEST_ID,
> >                 .state_list =3D LIST_HEAD_INIT(test_state.state_list),
> >                 .fields =3D (const struct kstate_field[]) {
> >                         KSTATE_BASE_TYPE(i, struct a, int),
> >                         KSTATE_BASE_TYPE(s, struct a, char [10]),
> >                         KSTATE_POINTER(p_ulong, struct a),
> >                         KSTATE_PAGE(page, struct a),
> >                         KSTATE_END_OF_LIST()
> >                 },
> >         };
>
> Hmm, this still requires manual efforts to implement this, so potentially
> a lot of work given how many drivers we have in-tree.
>

We are not going to have every possible driver to be able to persist its st=
ate.
I think the main target is VFIO driver which also implies PCI/IOMMU.

Besides, we'll need to persist only some fields of the struct, not the
entire thing.
There is no way to automate such decisions, so there will be some
manual effort anyway.


> And those KSTATE_* stuffs look a lot similar to BTF:
> https://docs.kernel.org/bpf/btf.html
>
> So, any possibility to reuse BTF here?

Perhaps, but I don't see it right away. I'll think about it.

> Note, BTF is automatically generated by pahole, no manual effort is requi=
red.

Nothing will save us from manual efforts of what parts of data we want to s=
ave,
so there has to be some way to mark that data.
Also same C types may represent different kind of data, e.g.
we may have an address to some persistent data (in linear mapping)
stored as an 'unsigned long address'.
Because of KASLR we can't copy 'address' by value, we'll need to save
it as an offset from PAGE_OFFSET
and add PAGE_OFFSET of the new kernel on restore.


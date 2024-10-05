Return-Path: <linux-kernel+bounces-351615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F14129913A4
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 03:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FBE8B21BA8
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 01:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FFC4C9F;
	Sat,  5 Oct 2024 01:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1Wi9rYXQ"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAE54A3E
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 01:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728090255; cv=none; b=eX6y/VOuVYhp1wS/VJNhcwULd7PV6WYfcXbR15Hj2p0Xn4sGwULu4wZZN1ec8SxLSAcVuwnDSkXe0NwBmDF5Rr1j72SMMlVpVWj37fF4XeSvnnBLXuLHGA55LbAHEH14yWlA6htm3Gm5kLNtBuO/OEkil6GUm45Inu2ISAVak4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728090255; c=relaxed/simple;
	bh=+Hllg7Ei1kQ90PkyK7T+LkkHENwzGhCWKO33DkU90vM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ii9Ho7GGbfNNdMcNO2xFBZQD5gt3TgOT4iNuQVEwewfgQU0tO0vxdB+vqTUeZpwX7H8ApylVUR0ygGAoaa8p42a59yPvXXBxaZroD2/7UaZL/tF9bqQi3J2W6h4EJyGUDuz1Jd2r2Jody2rG8QQl0GNZCdY0g0TfbDrAEHHfwbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1Wi9rYXQ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c87a7782beso4710a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 18:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728090252; x=1728695052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvGWKlnjWQBeRKa2edao+xrpWXp1CYlba5T40jSMewE=;
        b=1Wi9rYXQS/tU9cYinYdvOGd9GSf5qnMBh7WW68rS/vN/vQ7gQC7mGO88GNOjlf83mI
         IZQFSC7Lnz+xyj+NcLH59EaO5Z/X9JiBCXr7ph6gspwsbFiI+Vuo6WDm8xmOZUoSfUI4
         2SIVaEL8xSyIlXviBOTxP74qvBRgOHGqe+2y3G60xmop9PLyII9DnwGxDUg0keGwJ+Ef
         rX5QgZLCzgU65c2jbiGQxNXQm2ItCIC3MV7Xal9+W6P2T0BxKnvASHKiVuk2nAkCh9c8
         jC1ZrVfU7mwyj88QdDrFKE1JiF+IHYqb9K12tlFd6J3ZRu401qV1CGSOuagwlN4nf5nV
         wDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728090252; x=1728695052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tvGWKlnjWQBeRKa2edao+xrpWXp1CYlba5T40jSMewE=;
        b=RX7yJl7/max8CmBKTcKIwkwoDd5Yd637tz/AznkEDROw4SNNk339oyTg/+Aq2+4HkM
         oKZJdqRvRDDQ1e3BjnLlNCCEuAd4ZIjlIX2NcIGUH/zLuu8giiZuxYh6UKdMJVNah8mg
         S2i01fzPZm2aICwn5mJYS9CK/1sU2QnTWBQ//fnvYqrxz4suraQZN2nGg4yT2iiEuI0E
         RhTTYqx2cd6o8L6becORnwoJxH218G9drQ9Bm5vTsT7vjEjjXmb/OZHYZMW4CslHqNpy
         js45FM3qdEdNQ2USuCtIcEpRSx/7ew9mo3lTN6EQgrWoQ3hsEKakt28o/88LJeaia9y9
         FWFg==
X-Forwarded-Encrypted: i=1; AJvYcCV4cM7Hd6+79/4fF0e2A/bsakrKBZOiAbsNfWt40N0YSKXJVI3b5wD5Wqqq4JwSej8DNu7PbWntCP1OK0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqDscLSbFdZsllY9wR4qNHRIkG+e93WwixLMT3zTT0Eel0dSns
	pNHNG2KXTbWtAvuCyEpZmFZNBM0Y7UtkQIL5+8cmamYsYwHy32ziSSW95H8zvnWge/EEEaLlqXs
	5b8D0/+umQ3T0zflDVvnPpoDqa4n+zL6F/na8
X-Google-Smtp-Source: AGHT+IGDAlry6zV66LY9gAmPT1eybIGYw49sB0rcxhPA60/E0wfpIIBO2lfeMekrYW+O8ONemKk3E7d2G2TyNAe7quY=
X-Received: by 2002:a05:6402:5251:b0:5c7:18f8:38a6 with SMTP id
 4fb4d7f45d1cf-5c8e1e8b32amr77729a12.5.1728090251434; Fri, 04 Oct 2024
 18:04:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004180405.555194-1-yang@os.amperecomputing.com>
 <CAE2F3rDH3aK-OLO6TSXgQFU+DDx6Rq+4uwLQb3WZ+CMWWEGCNQ@mail.gmail.com> <87ac9686-cffb-43ac-b8f0-ccd3632fe5cd@os.amperecomputing.com>
In-Reply-To: <87ac9686-cffb-43ac-b8f0-ccd3632fe5cd@os.amperecomputing.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Fri, 4 Oct 2024 18:03:57 -0700
Message-ID: <CAE2F3rARZ_qq7MYnAT7nNKcNsL3DzaTH+ehPTNrwaaP20d9Cag@mail.gmail.com>
Subject: Re: [v3 PATCH] iommu/arm-smmu-v3: Fix L1 stream table index
 calculation for 32-bit sid size
To: Yang Shi <yang@os.amperecomputing.com>
Cc: jgg@ziepe.ca, nicolinc@nvidia.com, james.morse@arm.com, will@kernel.org, 
	robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 2:47=E2=80=AFPM Yang Shi <yang@os.amperecomputing.co=
m> wrote:
> On 10/4/24 2:14 PM, Daniel Mentz wrote:
> > On Fri, Oct 4, 2024 at 11:04=E2=80=AFAM Yang Shi <yang@os.amperecomputi=
ng.com> wrote:
> >>   static int arm_smmu_init_strtab_linear(struct arm_smmu_device *smmu)
> >>   {
> >> -       u32 size;
> >> +       u64 size;
> >>          struct arm_smmu_strtab_cfg *cfg =3D &smmu->strtab_cfg;
> >> +       u64 num_sids =3D arm_smmu_strtab_num_sids(smmu);
> >> +
> >> +       size =3D num_sids * sizeof(struct arm_smmu_ste);
> >> +       /* The max size for dmam_alloc_coherent() is 32-bit */
> > I'd remove this comment. I assume the intent here was to say that the
> > maximum size is 4GB (not 32 bit). I also can't find any reference to
> > this limitation. Where does dmam_alloc_coherent() limit the size of an
> > allocation to 4GB? Also, this comment might not be applicable to 64
> > bit platforms.
>
> The "size" parameter passed to dmam_alloc_coherent() is size_t type
> which is unsigned int.

I believe that this is true only for 32 bit platforms. On arm64,
unsigned int is 32 bit, whereas size_t is 64 bit. I'm still in favor
of removing that comment, because it's not applicable to arm64.

> >
> >> -       cfg->linear.num_ents =3D 1 << smmu->sid_bits;
> >> +       cfg->linear.num_ents =3D num_sids;
> > If you're worried about 32 bit platforms, then I'm wondering if this
> > also needs some attention. cfg->linear.num_ents is defined as an
> > unsigned int and num_sids could potentially be outside the range of an
> > unsigned int on 32 bit platforms.
>
> The (size > SIZE_MAX) check can guarantee excessively large num_sids
> won't reach here.

Now that I think about it, unsigned int is 32 bit even on arm64. So,
I'm afraid this could (theoretically) overflow. On arm64, I don't
think that the (size > SIZE_MAX) check will prevent this.

> >> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iom=
mu/arm/arm-smmu-v3/arm-smmu-v3.h
> >> index 1e9952ca989f..c8ceddc5e8ef 100644
> >> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> >> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> >> @@ -853,6 +853,11 @@ struct arm_smmu_master_domain {
> >>          ioasid_t ssid;
> >>   };
> >>
> >> +static inline u64 arm_smmu_strtab_num_sids(struct arm_smmu_device *sm=
mu)
> >> +{
> >> +       return (1ULL << smmu->sid_bits);
> >> +}
> >> +
> > I'm wondering if it makes sense to move this up and put it right
> > before arm_smmu_strtab_l1_idx(). That way, all the arm_smmu_strtab_*
> > functions are in one place.
>
> I did it. But the function uses struct arm_smmu_device which is defined
> after those arm_smmu_strtab_* helpers. I have to put the helper after
> struct arm_smmu_device definition to avoid compile error. We may
> consider re-organize the header file to group them better, but I don't
> think it is urgent enough and it seems out of the scope of the bug fix
> patch. I really want to have the bug fix landed in upstream ASAP.

Understood. Thanks. We could move the changes in
arm_smmu_init_strtab_linear() into a separate patch to accelerate the
process. I'm fine either way, though. I don't want to get in the way
of this landing upstream.

>
> >
> > On a related note, in arm_smmu_init_strtab_2lvl() we're capping the
> > number of l1 entries at STRTAB_MAX_L1_ENTRIES for 2 level stream
> > tables. I'm thinking it would make sense to limit the size of linear
> > stream tables for the same reasons.
>
> Yes, this also works. But I don't know what value should be used. Jason
> actually suggested (size > SIZE_512M) in v2 review, but I thought the
> value is a magic number. Why 512M? Just because it is too large for
> allocation. So I picked up SIZE_MAX, just because it is the largest size
> supported by size_t type.

I think it should be capped to STRTAB_MAX_L1_ENTRIES


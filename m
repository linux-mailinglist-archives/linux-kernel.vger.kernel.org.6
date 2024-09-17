Return-Path: <linux-kernel+bounces-331859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AF797B21B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 17:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F044282B52
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06CB1D0DE1;
	Tue, 17 Sep 2024 15:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A9JhALVA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7342917C9B5
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 15:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726586561; cv=none; b=jC9jAZBDy9oPShER9GghCn6x9Vn6CK5D/Q5jYQR/Oh97ZYNyNkxlhmq+rsQUKbfvjjXDb0tKW60HwXnGL0C9vfvHWgrz4bafRSvGPZGlUZf6kEpCE5EzsejhgVxKglthsY9sSpdFq5cNeXgjoiQpobD49zBCVMU0RFOosMq435s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726586561; c=relaxed/simple;
	bh=/PklNxOBmAhcx3M/RDpgql1gjxEINNmnEgxxr/Ido5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rA9j6KxNzk+3+L3s6A8mRuyiZz5I9yQs4DTtokaDPdU7TU1RFaYTB7/F6EGzG1kNWaujtOXrkQCdhg5GpryqT8dmdfAGeIrtLYHR1oT2f+dcz60qTpQSPrhguvTm8Otdth2lLg4XJqYW9mwyo46CHAlP6iCAozfR6VhET1+9q0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A9JhALVA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726586558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kVNzcPJtWdGeNQl5mUfxLbMTyPgjJZvkVqNPRnpN6Ts=;
	b=A9JhALVA124nzreCfP9JJu4pIlQsskCXqlsr53xjUUbDza51aB47emqIhjuwNTAANfkyfi
	xQPWl3evIfSPO0rpQ8LMSlMRGDyEB/kM4ncGDM9iMybM+SSMbOlUYdicmp7qmGcxqXE5b0
	4FS4njNwog8O/rVmSVmbB+E8titj3ug=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-8ahQjVWsP4ytiIWs2D4u5A-1; Tue, 17 Sep 2024 11:22:37 -0400
X-MC-Unique: 8ahQjVWsP4ytiIWs2D4u5A-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7a9b6181a13so1416923785a.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 08:22:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726586556; x=1727191356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVNzcPJtWdGeNQl5mUfxLbMTyPgjJZvkVqNPRnpN6Ts=;
        b=tsLjV7n2DegqR5r1aNI8PzxVi6T84mkHn2FoCiGGx9Q25o1M5HdAYz9bRiN6uR52jy
         DHUH/Bsv2EbwRbJVV651bgMnXtPx5HEzke26+UGvqXN5OHeoHghvCUHGcIKhwYuFPjWL
         7ZAq89Z6biSrSvuZnrwIRV0bzTwl3N66yJXXtQ09vWEqdHP3kvSqYspri2U4uWOzxiLD
         EnoH6o3/HAc/KhiQ/IzwUhAxY9PSXHB2TED7TekfySRezIJm19LW0PMODUrjMRcNAdzQ
         RNeTyvq3tPdK9Wwr9sGmRZIoINUm2BW3Sm7JcSPKvZy+TA7BaERfBZC+2t0zQqx4wKc4
         WvQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVshoesu+M5JoZivnhCvYTUryEJGWF83p3xJDfoiNH2TMk52FR/3XhtHynm2xSk9qus/1J1WxI8Tp+STtU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf/f+4RP1F7x8KhfMBHxzt1aebNt9ojjqn6/ZsiLCPH60Zc4D4
	tu5WMMNSzG+dCCfdNwddvriJVNLr1rtX6hG+Rt4ImraFspIbOULU5cj5DH9aaMgs4FAu+6eCK38
	chCYcsOI13X/UJKKyLBtyYroTeuAq2lt4uYhhoqI78L17pcPfzIkmBRcahqnmiA==
X-Received: by 2002:a05:620a:484:b0:7ac:a077:6a1e with SMTP id af79cd13be357-7aca0776ac1mr194409585a.9.1726586555834;
        Tue, 17 Sep 2024 08:22:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4xX1n5vRQPcE2i5odLOKTy7iWO0rD+5f1yG6JD9ULO+gdNCAcyCtvfbS9/cxvUhtWHamzNw==
X-Received: by 2002:a05:620a:484:b0:7ac:a077:6a1e with SMTP id af79cd13be357-7aca0776ac1mr194407385a.9.1726586555449;
        Tue, 17 Sep 2024 08:22:35 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ab3e95e99fsm367173885a.17.2024.09.17.08.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 08:22:34 -0700 (PDT)
Date: Tue, 17 Sep 2024 11:22:31 -0400
From: Peter Xu <peterx@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Ani Sinha <anisinha@redhat.com>, linux-kernel@vger.kernel.org,
	qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v10 02/21] acpi/generic_event_device: Update GHES
 migration to cover hest addr
Message-ID: <ZumetxyRro8RfC8h@x1n>
References: <cover.1726293808.git.mchehab+huawei@kernel.org>
 <bed4b2da51e0c894cc255f712b67e2e57295d826.1726293808.git.mchehab+huawei@kernel.org>
 <20240917111921.7e95726b@imammedo.users.ipa.redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240917111921.7e95726b@imammedo.users.ipa.redhat.com>

On Tue, Sep 17, 2024 at 11:19:21AM +0200, Igor Mammedov wrote:
> On Sat, 14 Sep 2024 08:13:23 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > The GHES migration logic at GED should now support HEST table
> > location too.
> > 
> > Increase migration version and change needed to check for both
> > ghes_addr_le and hest_addr_le
> But I don't think it will work like this (but I might be easily wrong)
> However I don't know enough to properly review this patch, CCing Peter & Fabiano
> 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  hw/acpi/generic_event_device.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> > index 15b4c3ebbf24..4e5e387ee2df 100644
> > --- a/hw/acpi/generic_event_device.c
> > +++ b/hw/acpi/generic_event_device.c
> > @@ -343,10 +343,11 @@ static const VMStateDescription vmstate_ged_state = {
> >  
> >  static const VMStateDescription vmstate_ghes = {
> >      .name = "acpi-ghes",
> > -    .version_id = 1,
> > -    .minimum_version_id = 1,
> > +    .version_id = 2,
> > +    .minimum_version_id = 2,
> >      .fields = (const VMStateField[]) {
> >          VMSTATE_UINT64(ghes_addr_le, AcpiGhesState),
> > +        VMSTATE_UINT64(hest_addr_le, AcpiGhesState),
> >          VMSTATE_END_OF_LIST()
> >      },
> >  };
> > @@ -354,13 +355,13 @@ static const VMStateDescription vmstate_ghes = {
> >  static bool ghes_needed(void *opaque)
> >  {
> >      AcpiGedState *s = opaque;
> > -    return s->ghes_state.ghes_addr_le;
> > +    return s->ghes_state.ghes_addr_le && s->ghes_state.hest_addr_le;
> >  }
> 
> what I would do:
>   add ghes_needed_v2(): return  s->ghes_state.hest_addr_le;
> 
> and then instead of reusing vmstate_ghes_state would add new
> vmstate_ghes_v2_state subsection that migrates only 
>   VMSTATE_UINT64(hest_addr_le, AcpiGhesState)
> field.
> 
> btw: we probably don't need ghes_addr_le for new code that
> uses HEST to lookup relevant error status block.
> but we should still keep it for 9.1 and older machine types
> as they expect/use it. Separate subsections would work with
> this req just fine.

Right, if we need bi-directional migration we need above and a compat
property (or VMSTATE_UINT64_TEST() would work too, iiuc).

OTOH VMSD versioning only works for forward migration, not backward.

> 
> >  static const VMStateDescription vmstate_ghes_state = {
> >      .name = "acpi-ged/ghes",
> > -    .version_id = 1,
> > -    .minimum_version_id = 1,
> > +    .version_id = 2,
> > +    .minimum_version_id = 2,

(and IIUC if we set min ver=2, even forward migration should fail.. better
 test it with an old binary, migrating back and forth)

> >      .needed = ghes_needed,
> >      .fields = (const VMStateField[]) {
> >          VMSTATE_STRUCT(ghes_state, AcpiGedState, 1,
> 

Thanks,

-- 
Peter Xu



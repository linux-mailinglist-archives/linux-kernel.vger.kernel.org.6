Return-Path: <linux-kernel+bounces-253668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09183932494
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 996E7284F82
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 11:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A6F198E78;
	Tue, 16 Jul 2024 11:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q7zy8ngB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0511CFBE
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 11:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721127925; cv=none; b=a0HWDwfjCOOwb5HyQXwuuyZ4/3od2MH/ZJ7AcT61RvT1GXXfZeIn+EdFiO10OfxW5CET6EfzAdqyaZFS6W7FjUmYbanCrak/h+qZ39F6qoUrIindup5Z2/VY2vLJb+42gb27MRiLhaH3EKyE9+vBmDB/M9RJ2hli8r51VRHAl/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721127925; c=relaxed/simple;
	bh=MvIKsgrPQglT3a9IU8dOgBq33mZYbzlTkWmeXb+3Too=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkluww6ZF/x+ymAvvqUCQvQG3uRBNWQssL9it32GqiehW0YZwf0UjdE66tnLYkcZIfOxJ2XAHYoGn9nRpBVIoOtHmSJpbxIFL4TdS6ng9s/DsE19XW2jTd/LTvCFVK0Cpwms1lqh/QVZKpJvt/2502GZtWBdKaQrVMC7VUuTkLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q7zy8ngB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721127922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pYv78XViBnNALVFj6b/jz4i+MNwS3QQZFpa8XTMdeZ0=;
	b=Q7zy8ngB8ItxvrpvKewfzTEiwi8X6cS5Tg6rM8Ue/MIHtVCpHjEmeR7ONfxmuhX8NB6NBz
	/Tpnp6jup67NzuTwLwGhsiAQaCyhzW1SAt31HNmopTkI6qpXs6YMGWf9mQnFLxFvKHHVOQ
	rAEOmoPZegyn8HaRkcVPDv9qtNoKtek=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-NWVdHVBTMnuArRJB_qD69Q-1; Tue, 16 Jul 2024 07:05:20 -0400
X-MC-Unique: NWVdHVBTMnuArRJB_qD69Q-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ee8e0dab26so48722341fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 04:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721127918; x=1721732718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYv78XViBnNALVFj6b/jz4i+MNwS3QQZFpa8XTMdeZ0=;
        b=p+kT+7LKlFUsJYF/puJdMAzKycXwOPJxkg3NH0wxnQ198q5BhdNqxYG5CL4CjlL8be
         DNljoENg8SXCns67K7R1yDRwz3X5LiuaIZbtKQCh4M+OfUD7q2qLyxtsboAfQY0Za+lY
         FnLkLHhatRtqMSrguGFzF5vXT2auC+MLtn+7raGfPnZceq1zm5IBnAm9MaDzaOXZC3EL
         4x2sh5vRuZDQq4WScTjHitF5UNSwaCLn/jshkglpWA+g3ez8tZRw5kSZRedQpr+y8LhO
         erxX45kkxIOsaf5abJIWhMidQsqwg6jWjXlVSgB9JqYPJb13xvv0beTMPnzNwCzYON/I
         xicw==
X-Forwarded-Encrypted: i=1; AJvYcCXQfJ0WJePl0YpADAGH7Nx4iukP8diU5FJuxjPVnXF1tWnE89NlNB/ft3+8X4MKmII2qYcNsf/wuqgmAd2yWV47qNvXIA2X1WlYbFpD
X-Gm-Message-State: AOJu0YzcKJeQkBnBD0XJiNvNsGDNmdl7RLhTY3SpHrXG1qqcILXveIyt
	D2ILiSLoMvEA3XQ8DxO5onJdqWyWiyjttz4kT4LiOwCWTxi24cxnbEzStYvKib3tX7eVXbdK6oK
	LMKbPpx6+Ne4sDZj1bpfQVkm0FjJJRFon6UXziDfNrgdFXZKYMHv7PbKV3eor7g6SR3H2IQ==
X-Received: by 2002:a05:651c:4ca:b0:2ee:6277:a888 with SMTP id 38308e7fff4ca-2eef41d8eb8mr15529171fa.38.1721127918664;
        Tue, 16 Jul 2024 04:05:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuz0u0LK36T2lX3jv3BCMXbENBiqBlty86viaW1774/T9hdKdb6NXwWQ8/ImGkAipFLtUvoA==
X-Received: by 2002:a05:651c:4ca:b0:2ee:6277:a888 with SMTP id 38308e7fff4ca-2eef41d8eb8mr15528891fa.38.1721127917938;
        Tue, 16 Jul 2024 04:05:17 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:243:da88:7ff9:68fc:2f43:bcdf])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b26f61fcasm4714101a12.86.2024.07.16.04.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 04:05:17 -0700 (PDT)
Date: Tue, 16 Jul 2024 07:05:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@nvidia.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Jiri Pirko <jiri@resnulli.us>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the vhost tree
Message-ID: <20240716070452-mutt-send-email-mst@kernel.org>
References: <20240715171041.5d0ec5a1@canb.auug.org.au>
 <ZpTXa-E1SpFJfVBw@nanopsycho.orion>
 <20240715045026-mutt-send-email-mst@kernel.org>
 <ZpYURX4IrW05U_O5@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpYURX4IrW05U_O5@nanopsycho.orion>

On Tue, Jul 16, 2024 at 08:33:41AM +0200, Jiri Pirko wrote:
> Mon, Jul 15, 2024 at 10:50:43AM CEST, mst@redhat.com wrote:
> >On Mon, Jul 15, 2024 at 10:01:47AM +0200, Jiri Pirko wrote:
> >> Mon, Jul 15, 2024 at 09:10:41AM CEST, sfr@canb.auug.org.au wrote:
> >> >Hi all,
> >> >
> >> >After merging the vhost tree, today's linux-next build (htmldocs)
> >> >produced this warning:
> >> >
> >> >include/linux/virtio_config.h:136: warning: Excess struct member 'create_avq' description in 'virtio_config_ops'
> >> >include/linux/virtio_config.h:136: warning: Excess struct member 'destroy_avq' description in 'virtio_config_ops'
> >> >
> >> >Introduced by commit
> >> >
> >> >  e6bb1118f6da ("virtio: create admin queues alongside other virtqueues")
> >> 
> >> Ah, leftover, will send fix. Thx!
> >
> >Better squash it.
> 
> Does it mean you take care of that in your tree?
> 
> >
> >> >
> >> >-- 
> >> >Cheers,
> >> >Stephen Rothwell
> >> 
> >

It's easier for me if you just post a new version of the patchset.

-- 
MST



Return-Path: <linux-kernel+bounces-252827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B3193188A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 18:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9AC1B2298C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DCA1CD1B;
	Mon, 15 Jul 2024 16:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ABKj8apY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A061C2BD
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 16:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721061343; cv=none; b=iC/0NCmK0GmYH4RW9YjG1fGnZ6hUEvQOrm1grNxjKMt8vdcRTOmp0BLi8draZhGHD92vst6VERj4HTu78y/tsjVlBHQvlAKDTMWDcSQm+clZw0CyX3dyS2n+zJYyNvozH3SpzMcitV9+1E9Eja3oBUQmTVQDBf6QibbiR3xfEVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721061343; c=relaxed/simple;
	bh=odHtKhyc9x4N+VpJWpMYT8G+At8j5bJ+9xLfXcp3Ibw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qPuUTPNvZpQo4G2yZuKCP3zd6Us+AUbgdjO9GY4hy7wPG0rxeoLx64KWgMopKcURPnSlbDJzR+ErHRJ+JXd5UBSbm+xDoO+TP5RieC5mJYDiy2Pk9EP6o0WnaOTxZrFl5xPbdxHDfrlYcAhgLh09NuvSy0wuZBcOVV7e8La6bBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ABKj8apY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721061341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iS9Rw1EkQ2Yc2L2pZuUTIBeOwAXBu/F5Bf6ABfLlinU=;
	b=ABKj8apYav5iK5fhj6b0On/XH6rThwKHKGgkEtNPCGOYe4ver8eaweCOog6yaBoLqCR8N1
	jX5b8+NSliuTgIzV22Sfryiq5TSNzL1f/E0/QsGjh9YiMvlXqVRDShrvFyGsfgdLQwNTZC
	MaPjNUZsObU7I0VHufOMEsnQOGTqVjA=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-w_t0xSjrOGqxELdlmFV0BA-1; Mon, 15 Jul 2024 12:35:39 -0400
X-MC-Unique: w_t0xSjrOGqxELdlmFV0BA-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-391ef6a843eso17443635ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 09:35:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721061339; x=1721666139;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iS9Rw1EkQ2Yc2L2pZuUTIBeOwAXBu/F5Bf6ABfLlinU=;
        b=dRR6g+pyH9541A6sssSYbVRVzY/3fFEDJvlwTOCQx2adJeV0veRe1LoLenJ0/EYx1k
         Kqypug342TfCYbtE0N423B7XQMs6IB5Xh4nQVMnc9//j2vliZzNL8MJQN9e+m9CkIybi
         xEOG184l1q7k4uvDplIoByDT3SXAjYP7Ukr3oCjh+eUwGzcat1mYScX1/Ubdjc4cBj2M
         tcUrKTRzEdFfSqMdjdefdFSY/g+7gJwW9VKyD5A7UzcU6CQT4etf3qifG1pts2oEqb5S
         OdjQWzWwMMj3XCBWhVv1yHmR6mM6vj/HpAwPzTNLwzNW1g+KlOpAGHW/ES/3vqwKeOdo
         K4kg==
X-Forwarded-Encrypted: i=1; AJvYcCXIXSHpxyJgF095g45dfs7h1wDByQiWPrQ70wA9s5/+LhV/rykCBaqD9V+48sjJTNLHD8VoZvLNZj01X3bFIQnBKW1VnxUOIo6fGAXM
X-Gm-Message-State: AOJu0Yxj91w5cfPTL4TSVgdjUT7FR3Tf9n24/ZAKcvOQmaGq8yd3EBqO
	KC+ATsry3xHoYEK7Xc+1Fikf4VWCnZXmGiAj9mJHgHOkm7cgiZCPwekRxb4HQn6Od+/BXORiGe7
	zqNMfH1Vvuu3/Yy3OER8sU/QC9hpbLDIYAq9if09JxC/qh/s4x6il0zAW6kxm5g==
X-Received: by 2002:a05:6e02:20e1:b0:374:9b99:752a with SMTP id e9e14a558f8ab-3939f4af59fmr4333755ab.14.1721061339010;
        Mon, 15 Jul 2024 09:35:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5GGCFUYrZmA3U7gSzsm3iXM+W7dKssQ9LTw5nTg2Z6p8f6D0pQ16AxdkbJqYZil9SOQDSiA==
X-Received: by 2002:a05:6e02:20e1:b0:374:9b99:752a with SMTP id e9e14a558f8ab-3939f4af59fmr4333545ab.14.1721061338793;
        Mon, 15 Jul 2024 09:35:38 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39010ce5f54sm17490725ab.56.2024.07.15.09.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 09:35:38 -0700 (PDT)
Date: Mon, 15 Jul 2024 10:35:36 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Kirti Wankhede <kwankhede@nvidia.com>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "kernel-janitors@vger.kernel.org"
 <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] vfio-mdev: add MODULE_DESCRIPTION() macros
Message-ID: <20240715103536.3e1370ef.alex.williamson@redhat.com>
In-Reply-To: <3717c990-ac93-4a43-a33c-bce02a066dfd@quicinc.com>
References: <20240523-md-vfio-mdev-v1-1-4676cd532b10@quicinc.com>
	<a94604eb-7ea6-4813-aa78-6c73f7d4253a@quicinc.com>
	<MN2PR12MB420688C51B3F2CC8BF8CA3A8DCA62@MN2PR12MB4206.namprd12.prod.outlook.com>
	<20240712163621.6f34ae98.alex.williamson@redhat.com>
	<3717c990-ac93-4a43-a33c-bce02a066dfd@quicinc.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jul 2024 09:17:41 -0700
Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> On 7/12/2024 3:36 PM, Alex Williamson wrote:>>>>   MODULE_LICENSE("GPL v2");
> >>>>   MODULE_INFO(supported, "Test driver that simulate serial port over PCI");
> >>>> +MODULE_DESCRIPTION("Test driver that simulate serial port over PCI");  
> > 
> > Seems the preceding MODULE_INFO needs to be removed here.  At best the
> > added MODULE_DESCRIPTION is redundant, but "supported" is not a
> > standard tag, so it's not clear what the purpose of that tag was meant
> > to be anyway.  Thanks,
> > 
> > Alex  
> 
> My preference would be to just add the missing MODULE_DESCRIPTION() with this
> patch since that fixes the existing warning. Removing an existing macro
> invocation is out of scope for what I'm trying to accomplish.

This adds a MODULE_DESCRIPTION that's redundant to the current
MODULE_INFO, therefore I'd argue that it's not out of scope to replace
the MODULE_INFO with a MODULE_DESCRIPTION to achieve your goal.  Thanks,

Alex



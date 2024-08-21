Return-Path: <linux-kernel+bounces-296261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDAD95A84A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 01:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96F04B231DB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 23:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F1717E005;
	Wed, 21 Aug 2024 23:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bos6mq5A"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAB3168497;
	Wed, 21 Aug 2024 23:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724282976; cv=none; b=NRpnWWei3NC/t8fuggxOMevCIs6gWmEUMdk6wOG7E3KM+vRNGuniYpFCKtyNOwVYVvejqzIedMPZB8wvLXOFVOJ5uUK6Ub+eDvdE18kYcvIppxhW/tY/7yDDJjcH9PV24MNOAFfe84o7DBQ3uKDX9fHTYSO/ulusVO1ebZhf41U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724282976; c=relaxed/simple;
	bh=iKLKVp0q2OFOpiEQmcXVCjL6yJHXON2BaLfw4qXLs7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alUHr87HUWIQdczCARpepcPFpBKfd0Ur6NQVV4oW0kLRw/apySQSyorY4ovL2/u+A4aVgyBpWu7JPfm7CTU4uCIHGGGoIO5z6ocd8gxkIRiDvbe7NeCQFNLF96qLZxHEY6k2vnSfaUWeqXOSKp+fAt9cbkLqdAjuJcf4WHpgVyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bos6mq5A; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-201d5af11a4so1790145ad.3;
        Wed, 21 Aug 2024 16:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724282974; x=1724887774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p9eqG/AuAzN9BQ1IvOUAq0gH8KXSHdtURNejNG+5pjc=;
        b=bos6mq5ABJSIKB8QSG7o280dbI0dIypTIlT3ed6pCTPnjOyTgezg8IM2oze91KhXWk
         kZUNKD840aTaUnNdCqGBkhVxQGrEWi2Gjh2ebT5Ql26WMNl+t1MVF1rdLvHH3Ewd2bub
         h/G8rmBI3NdqXswiaqU9QqoNqcTbXnbuUTyFzAqwJPCgRauQsSAMkF4ptHuGTMyiiTcM
         PpQB2x4AUzdhfTG24DSqNJudWqRYz3DcGQ4DNs1KHAd6BEx8d8U+JCL4+LE8s85yg0JQ
         CtkLD944fENpRXaBGlWuKSio/zWL3ioZhOB/jAxXxcx+j4I//0WCW4HBdwabwYukgHMM
         ZIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724282974; x=1724887774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9eqG/AuAzN9BQ1IvOUAq0gH8KXSHdtURNejNG+5pjc=;
        b=LRUO9+Ec2jKKO2jLaKTpec8Dnd7GRjNMjkgxaI5lFRrntaQHEkeULZkSQF0LAKpBOn
         4h1zH1P1BycW6p4pJ0qo8oGEuPuG4vZJ3anrjTyB068tf4cds7RfKPM5j3m0JxD5dlyU
         SBdPIe8cpXp/+UrY1vIc/kCtW231OHE+NZjnBot9yI6f4XuFEXGvM9XwUQ8LVG5mD6RD
         oRuOqvKTIGTpqEWIpPQU6oXGzOuEmaEswrQADNmKw1cVPWlUs1YOvFZAL/reI08in1pS
         UmSgX3RlDfX5OWdyaDdzrnrYBisHvgwPR6QyYHmF2cf4/dHnDRwD4+qPw6ZD/CM5Hkqn
         fpiQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1zmAgUNa7ZrFjNEa5uklf5wa+zTEDq6OEJ0ifmhDgK93lZGTMsTIOHfOAnkEUKP8P4i6AL+ySHVDCZA==@vger.kernel.org, AJvYcCVdjOt3TwLxE5iEoma9sjmXmIUC3qUZeMn9zw1+Ak8MOSUwif/JEvnqGfaMnlsGvG8xtnr9kiGlCO6bYV3C@vger.kernel.org
X-Gm-Message-State: AOJu0YzIiJxEX10qr+rUIUJYz7ai+g1usCa3KaFb5snINLrBT6vscMsz
	8epVBkRLxHSUO8Ii09ieW9wobAmzofQSsYwIu/aIybwntfVhCouH
X-Google-Smtp-Source: AGHT+IFc34+7Djwhviv0XoYdI80Bcp3RaTFDMlNNmoY0J5T9ESp3ZZBsAzStFYQ+fbt8xoqaIuNRiw==
X-Received: by 2002:a17:902:d4cc:b0:202:52c:8027 with SMTP id d9443c01a7336-2036808f52emr40483915ad.47.1724282974271;
        Wed, 21 Aug 2024 16:29:34 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385580826sm1331105ad.100.2024.08.21.16.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 16:29:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 21 Aug 2024 16:29:32 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
	Mario Limonciello <superm1@kernel.org>,
	Clemens Ladisch <clemens@ladisch.de>,
	Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (k10temp): Use cpu_feature_enabled() for
 detecting zen
Message-ID: <8e93ccd6-803e-4750-a1dd-69f243f5ddb7@roeck-us.net>
References: <20240820053558.1052853-1-superm1@kernel.org>
 <20240821130916.GA1062@yaz-khff2.amd.com>
 <cb08e5d9-17c1-457b-af9a-a172feb5e72f@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb08e5d9-17c1-457b-af9a-a172feb5e72f@amd.com>

On Wed, Aug 21, 2024 at 09:34:09AM -0500, Mario Limonciello wrote:
> On 8/21/2024 08:09, Yazen Ghannam wrote:
> > On Tue, Aug 20, 2024 at 12:35:57AM -0500, Mario Limonciello wrote:
> > > From: Mario Limonciello <mario.limonciello@amd.com>
> > > 
> > > This removes some boilerplate from the code and will allow adding
> > > future CPUs by just device IDs.
> > > 
> > 
> > I've been thinking that maybe we stop using PCI IDs entirely.
> > 
> > The PCIe devices that we match on are internal to the SoC. And they're
> > not optional. They're basically processor components that are exposed
> > through PCI config space for software convenience.
> > 
> > Thoughts?
> > 
> > Thanks,
> > Yazen
> 
> Yeah I think that's a good idea.  The one thing I want to make sure remains
> though is that k10temp automatically loads from a CPU modalias.
> 
> This is "tangential" to this patch except for the commit message reference
> to the PCI IDs.
> 

Based on the feedback I will not accept this patch but wait for a solution
which is acceptable for everyone involved from AMD.

Guenter


Return-Path: <linux-kernel+bounces-534161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC93A4639F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E56CD18881EB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8872222D1;
	Wed, 26 Feb 2025 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="inpkz+vP"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED502222C7
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740581321; cv=none; b=DsLeLCAwcxDeA8a/jehA2vuHcOLqsYCm29RX4LHwq/iqFQJ22b9ESX09kZL0FXqYolWn3YSMKwYhyEdjJ+Cr8JX06adyZF0GqjIpczm19rX/ONNNlWZRnflE/uNj7DsDGTjFvG3QW+qpfqnL3cTrOFyihb7M5DBQa67qwbn3FXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740581321; c=relaxed/simple;
	bh=su0PyH6fk/umxyHrvcwmhEHJXABA6CnmzbapAUQDlIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7JRIW8r+/nCDni++nLirejtNkAxlEHCRBogfeN110q5CwYD+SDR2t9xmjKAFY5gwyMt/afvqEWIlrHniwI8NXJ980W8nVS2mmcDB/bhhGZYPKkr/+6c/es53a3mdS4VFNk0xWT//aoGYDR71CkmGAFgGJaGj4emUglw4ESVW6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=inpkz+vP; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e04f87584dso10602689a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1740581318; x=1741186118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nMoILKIF7N8WQlVNtPKgkkC84yA+V5fRgKd3rLXRVvE=;
        b=inpkz+vPNl0mlm9nSbeeNnKOTt1q+9n6oHZNQrX7CjQukEe9Avk9f8bqnPOxPu0XDW
         2+hMyEhuzWWNA3Jzaw9AD8Or1ANsQAhJ+IT+M08iyUH99AJ3MkhkOMZSm2jLWDPmjWBv
         78ZZUHS+AjxLiiV0aOpALNWZoIDcoUD+Yy4EyAsFTIFSAlUI9jLw8vKNaj8YF2FWg0eq
         PrnjADb6w0dMtB9ytr7dq8WcoXjUNe7QfJWWOL3YiR0mcEA9Gwiup+qsdrKX+MAwN/I0
         EKoIH+9MNh4vjab2EQBAqv311ZV9B1LtdgsSb7WA9Cx0g3sDOyvibT/smDai2GDpMHuR
         jEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740581319; x=1741186119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nMoILKIF7N8WQlVNtPKgkkC84yA+V5fRgKd3rLXRVvE=;
        b=TLMPOn5IxHs2Qw2GjtR6S5QDSZXKVP7U6elkIID1SExOPWW8mG28h2ssKoVqftzvur
         4qUso6FNKSrp/zQIYykSyKJe9lKUZtfx79yO4LKLSexUxsnd1hCsoAb6ZfozLI+HvUdV
         eBawqmVZppZ4XknCn63PSn6Ju2gvsl+LJccvBe3qUxqZTRHQxV7OA9ZX+o7zllvfQg2J
         IKaCFzWGZN785ipd/E//5ISYbIyIETiAE9nV6OAtYbX+WwvwWX1nO9c3Gx+OzYFQMSQe
         TMdC20gOtDilmSUeYC9diDjhqGK1dNWL8mNnZ3FQx6PsCXeYAFZH1xjM9P+W1yCVIo1o
         IP9A==
X-Forwarded-Encrypted: i=1; AJvYcCWd3NvDNu7YqgfWe8llJDFQYp81F5Yyd0j/2ZvlsBL77S58Kx2aMGFO8A1sQjosHut0A/r+OhiAdC8yeTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpkokxPqG/yhXAl66/upd3v7JGRhRvdMzcSUeI6TdMp6a3VmDL
	OXBt/CWeKikHEijGRTC/MJcO+E4IcZt3FmSTAQxCLCO3BlnITS6N/PtnFr3wUDw=
X-Gm-Gg: ASbGncs5ou4zynhwNPdcKdN7KHHJphMP/ZpmOyYkbx9DzSCWvq38I4AdJMDT8RDKYJ6
	YnOqJ6yxXIvMd3+ZJzOVt9cETWBFge0gAga0QvAw26k2CvDvXWdhMcvkfFlwLpaezmoR7QFJbFL
	6Rhgh7fOKGhN627ZZlIic4U4Zojvo8XVI7GY1lnUIgFvLCir3QxACuLBjUYIEyiN65aIM/pVSQc
	uYJaZTHt0HCs3fK5ycG2gIi8xhZWT9J6vPLHNSzJqD87PB63rrMntAHpJgYFM8iyr8ZUtF5wQp8
	behz6iaKBbFS0+U7WMSH4Y63LITLnAI8GrrSHpCV9s4w0h4SKEcl/g==
X-Google-Smtp-Source: AGHT+IGtH1CcVMxMCJwtVi3LYJ16g2hv5Xsh1dW0fQCUJV+H/J70PtPy1kYytDJYuVvZvlxBA+dtIg==
X-Received: by 2002:a05:6402:5202:b0:5e0:7f52:226 with SMTP id 4fb4d7f45d1cf-5e4a0d45e24mr4468134a12.4.1740581317806;
        Wed, 26 Feb 2025 06:48:37 -0800 (PST)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e462032b00sm2912497a12.68.2025.02.26.06.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 06:48:37 -0800 (PST)
Date: Wed, 26 Feb 2025 15:48:35 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Jakub Kicinski <kuba@kernel.org>, 
	Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, netdev@vger.kernel.org, 
	Konrad Knitter <konrad.knitter@intel.com>, Jacob Keller <jacob.e.keller@intel.com>, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, 
	linux-kernel@vger.kernel.org, ITP Upstream <nxne.cnse.osdt.itp.upstreaming@intel.com>, 
	Carolina Jubran <cjubran@nvidia.com>
Subject: Re: [RFC net-next v2 1/2] devlink: add whole device devlink instance
Message-ID: <iiemy2zwko4iehuw6cgbipszcxonanjpumxzv4nbdvgvdgi5fx@jz3hkez3lygw>
References: <20250219164410.35665-1-przemyslaw.kitszel@intel.com>
 <20250219164410.35665-2-przemyslaw.kitszel@intel.com>
 <ybrtz77i3hbxdwau4k55xn5brsnrtyomg6u65eyqm4fh7nsnob@arqyloer2l5z>
 <87855c66-0ab4-4b40-81fa-b37149c17dca@intel.com>
 <zzyls3te4he2l5spf4wzfb53imuoemopwl774dzq5t5s22sg7l@37fk7fvgvnrr>
 <e027f9e5-ff3a-4bc1-8297-9400a4ff62a6@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e027f9e5-ff3a-4bc1-8297-9400a4ff62a6@intel.com>

Tue, Feb 25, 2025 at 04:40:49PM +0100, przemyslaw.kitszel@intel.com wrote:
>On 2/25/25 15:35, Jiri Pirko wrote:
>> Tue, Feb 25, 2025 at 12:30:49PM +0100, przemyslaw.kitszel@intel.com wrote:

[...]

>> > output, for all PFs and VFs on given device:
>> > 
>> > pci/0000:af:00:
>> >   name rss size 8 unit entry size_min 0 size_max 24 size_gran 1
>> >     resources:
>> >       name lut_512 size 0 unit entry size_min 0 size_max 16 size_gran 1
>> >       name lut_2048 size 8 unit entry size_min 0 size_max 8 size_gran 1
>> > 
>> > What is contributing to the hardness, this is not just one for all ice
>> > PFs, but one per device, which we distinguish via pci BDF.
>> 
>> How?
>
>code is in ice_adapter_index()

If you pass 2 pfs of the same device to a VM with random BDF, you get 2
ice_adapters, correct?

[...]


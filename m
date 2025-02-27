Return-Path: <linux-kernel+bounces-536275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C927BA47D8A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF10D3A82EB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E585E22D4DF;
	Thu, 27 Feb 2025 12:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="1dU9vfX3"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BA1225417
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 12:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740658954; cv=none; b=l96qisP3/CeqEvZCZ+pQS7HbFVXMOyQqflEBipHjDWvR0qXoxDzm+Y2VW9qcOraSy9Nv1khRXobEWVSiqi5OLdbftYrgP9OQb5sygtO8tPho7yrTz+yU8zlwOfzGqjVlrc/Z/FXhk3tVL9RKH0JHh2LQnh69MAl0BofE8+WTCWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740658954; c=relaxed/simple;
	bh=8xMy4hdNTAdiolk+YAG/ZLMRZgXFoXuyYcYFEWFfQoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktP0Y7i5jw9O6GShu+y6DFTaRqQha2MrGmFKJoEnqEg0mt9gPhEfjnKs+YriUJuxLhfd1UKvE3g8GtYNwPzb1iiFjqAE4kgk2yj0KlmVjRMPMFw1CwbU897dNBMRQuZHe5qF+mtopb7Qs2LhG/beqSH/WL2RSnTJSt1XI66aQZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=1dU9vfX3; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5ded368fcd9so1348811a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1740658950; x=1741263750; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rYOTm+6jHAEQKMi6xNvlm2nNMaMBH7Q2Y4qbi1PxB2w=;
        b=1dU9vfX3g3bVHWM+cctcvNWp7y/4FKuP6rFLzSYNBpNeH03tffh5XBtfqV6179BjI5
         vjTjtlhY/cwqag1y5g4thXgGfn+ggpIs8Teoeb8xCLBLfETJghQ1pBxS5wZOFBtTaE+Q
         C+nD+W4GXgTw2jJ7t9E1gGr724Iu3Q/6N2z71hO7qMbefCC65r/lxdN6Uptk2y56C9uu
         eNexfemcF6kY6n5T9Z/iJ+1FFhSYQqhC6hIroV3/JAbVDAFcj76cZYpTFn2uH0RYfdfg
         T/8tY049ApSj4dPuqdbkMGIyz1sD96Fd799pALXiy4wDewfUpaEvQJVOjUeQyF1z/SJJ
         aBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740658950; x=1741263750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rYOTm+6jHAEQKMi6xNvlm2nNMaMBH7Q2Y4qbi1PxB2w=;
        b=h61+SRI4Mz2wYA9tHRuyQJCmnRotxoaz58sd8CqEZsn/VWn54XSUGSAvSKJWYEr/go
         /IXoFMGbDMhcG2SvBcO4PwsLNgtpGkeq87R+P37MMSZocsT/AABUIsjYlto4tnjF08WO
         KFPOMvolARu+D+hz6OJNfcayfXgyOh9I2LynHUAv09npdNG2aJqo57j741kH+gK2rA0b
         oKreLbxCT6OYNI4hYkz5x82NMNyky6rf6RfJ1TAwRG3YvAbJBr8H1OBDyTHO4fVgS9/A
         YrJJRuWEPiYgzBUvCeHnwwoifPkqnQZ01Gs5S4NPZ5b6b9l76SIBjJYz9recs9uBnsCD
         AnmA==
X-Forwarded-Encrypted: i=1; AJvYcCVzS7GfrnmYFoQRIDwrFUNsBdLEROrSh2eJviBM69Sf8tY6jEFmfwMi322EU8L61J2InXv79Ynfq7hTM68=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbNM7eAPnVJdhafO/7X02BHf7CDo5zLRrJI+CTUXYNyvZ8mOXR
	RT//MsQVxHF979SfPoa0fY4UzlvdfhsMj6aw0NnG0tSEKdYYC3K8axXsXEyHhMo=
X-Gm-Gg: ASbGnctQfgbsap4WClA2HNnDRefL8bwZHfqJBvy+/i7mdVuYQ+PyIBeqNIrD3AwlSbW
	e0l2fdp8ew9eLFFmq0p6Ox3fou/RRHgYbNX6RGfuMSkDeHdT5RT7xxSPRSfuMMVp2FAb6i7Shxl
	/mt5JNAqspQkhGkHjg4Ajpa1p5lSnI6PXQLIvduf7yw5O/R31y8ARkn4MV4uPjw3s2dIopvyDIw
	Q9W7JMyWgX+SRPpAgyYpVrVRkgOcBWILHQbWCMx7Qh4UqLoZew9vY2ewceRVLvw3s6c/XgsW12x
	TwyEMixgma+hALJI+XHMHBdPrvZBicZVuFSTTAx75ow5qvnrRmil
X-Google-Smtp-Source: AGHT+IEUS1ErRHCieUA4KP9jo36VNA+6eC7KANGzDb6TJHoqoC05Nj4oxB1TboeC1Qn+fVY5Mtzo1Q==
X-Received: by 2002:a17:906:7954:b0:abf:38a:6498 with SMTP id a640c23a62f3a-abf038a920cmr513452866b.55.1740658950370;
        Thu, 27 Feb 2025 04:22:30 -0800 (PST)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c0b99a6sm117424466b.13.2025.02.27.04.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:22:29 -0800 (PST)
Date: Thu, 27 Feb 2025 13:22:25 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jiri Pirko <jiri@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, 
	Carolina Jubran <cjubran@nvidia.com>, Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next 03/10] devlink: Serialize access to rate domains
Message-ID: <kmjgcuyao7a7zb2u4554rj724ucpd2xqmf5yru4spdqim7zafk@2ry67hbehjgx>
References: <20250213180134.323929-1-tariqt@nvidia.com>
 <20250213180134.323929-4-tariqt@nvidia.com>
 <ieeem2dc5mifpj2t45wnruzxmo4cp35mbvrnsgkebsqpmxj5ib@hn7gphf6io7x>
 <20250218182130.757cc582@kernel.org>
 <qaznnl77zg24zh72axtv7vhbfdbxnzmr73bqr7qir5wu2r6n52@ob25uqzyxytm>
 <20250225174005.189f048d@kernel.org>
 <wgbtvsogtf4wgxyz7q4i6etcvlvk6oi3xyckie2f7mwb3gyrl4@m7ybivypoojl>
 <20250226185310.42305482@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226185310.42305482@kernel.org>

Thu, Feb 27, 2025 at 03:53:10AM +0100, kuba@kernel.org wrote:
>On Wed, 26 Feb 2025 15:44:35 +0100 Jiri Pirko wrote:
>> > Why would there still be PF instances? I'm not suggesting that you
>> > create a hierarchy of instances.  
>> 
>> I'm not sure how you imagine getting rid of them. One PCI PF
>> instantiates one devlink now. There are lots of configuration (e.g. params)
>> that is per-PF. You need this instance for that, how else would you do
>> per-PF things on shared ASIC instance?
>
>There are per-PF ports, right?

Depends. On normal host sr-iov, no. On smartnic where you have PF in
host, yes.


>
>> Creating SFs is per-PF operation for example. I didn't to thorough
>> analysis, but I'm sure there are couple of per-PF things like these.
>
>Seems like adding a port attribute to SF creation would be a much
>smaller extension than adding a layer of objects.
>
>> Also not breaking the existing users may be an argument to keep per-PF
>> instances.
>
>We're talking about multi-PF devices only. Besides pretty sure we 
>moved multiple params and health reporters to be per port, so IDK 
>what changed now.

Looks like pretty much all current NICs are multi-PFs, aren't they?



Return-Path: <linux-kernel+bounces-534142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE5AA46355
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 236711769F3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6C52222A1;
	Wed, 26 Feb 2025 14:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="HKTP/rEo"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40B2221711
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 14:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740581082; cv=none; b=E52pfCbEacYPtTdiFQLPj0apofqceO67t31WdNL6m5qDBKvLN9b0r++HHigLKt1dYhTm557L9bWqaDu1K07Dv58iqRVmC+g3MjDob1929lptJ8XNJaSSGygfrafVoRZxkcTYE1ALYxAx65TXTA+iKdmu4qpolVUOwMOWg3RvOfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740581082; c=relaxed/simple;
	bh=kU/v7wqnqnL/CUwnJwMJlEh59FgkJ8snU821pG4Y7vI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hhs/wy5MYC086kPMmfC7aWNsDnGWAWlvLZz1on7xbv7ZSj+z6Na3nuJnApiTKbCeblbFjMc5TRYsrOCQdKyMzPJZ0ohQecm31GRSq6vkML5vdHCN46rXQH7rGWsj++WrRKPxdeVV3xn72X9nTaTCuRtV4ks6L4TL/dpLIR/ngwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=HKTP/rEo; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abbd96bef64so1132696966b.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1740581079; x=1741185879; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t3lgX5xVuREpMskRYofLOpLEr+lAUcsjQpUjCM0xtcE=;
        b=HKTP/rEol4MUDaKRuNqYBS4LAinMV1RbRDy5AIFnFpP37rJ+cHLPKFoxE4Ke7fga3d
         luty92mDw39JL/6RPiQBQPc3Bvs1SuICsdL5bpjQ9fcnTtpH2eZoNrRE+ltjdz/hWdlj
         UPUDUSwMsajcdFOH8jap2vAQWwZnok1dzcB8N5U7sZcCKLzlarGMd5czaF49V2e9XyKx
         4pGkGTY1YctwNcH7/IOFozPvwB61T57iRHASXEcLxRU87haPmok09+FmGT0oN5MOF50T
         3BRlq7tmgeeQVEDMHBkeSDe6R2UeaSfYrQ1NBP6aJGe35I37yZUnZZjEbCXhm8CLgqEM
         /yRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740581079; x=1741185879;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t3lgX5xVuREpMskRYofLOpLEr+lAUcsjQpUjCM0xtcE=;
        b=YOUJ3zoVCPX9rR+MNQmz28uAZ4uet58m3BRb18W81Jm9qj66J6qd+9SN1viXvyEsxo
         9zcbDuco7igH51NG7ttJwnxPTCuEax8P8vK3IVPQjJV7fB9QbE3FgGyRLsPbiXZNR1P0
         71Uc5P+DU2alANZH1I+C/4/jEe9PmNCz+2XiyIN7StcITGsRtyD+FrOuaMSo7BxjPC5x
         jQcI4M5+eqlyWTtnu7OKLD+SCmIOSDDOEfl3JGsXm4YEtXYMLv9ohlqfh6O3EAdkgJnZ
         bmWVxZSYa4KORaYxJtZ4H1Ks98t/vZc/aZycyaa/OTuJCKSudl+v7IdUJpadt+Hl7YKO
         dXlg==
X-Forwarded-Encrypted: i=1; AJvYcCUBNtKrNAcqR04fZ254a51QiuIdPGiCCyCBONH0VCPx+0VGiCGFTy7yuQneWzJO1OaWCLrZI0q3WIzWWso=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVTgFmZML6N6aUSg+DTwviKiFUdVb6b8z01T7BWbpEwoF/sk8D
	954TmkthYsZ9Qvu9Qf+f6sqINro7AC5FaNmAg/VEmah70dHR9c0QTum1flNeGgo=
X-Gm-Gg: ASbGncu9V74/tgTfRDii7CxEtBJji/5gDozyCPsPjFcOlQ4UjK2d3tNLUplbMu5KB5E
	GYfLVC8xLFOC9pwM8044PFCtgqByKkbLyWim3/ZucG3Mp+HwgDNL7I1ZDu1O0dkK+Y5TLAZUOiT
	2PA/6ZDC4qhxqtcwxIfNwby8JgHrC7gUX6RrO1R3aFjNwfdEOa26iaxoWmEixiqZ4mjTdQn0f3u
	drwYEtZ4AqQCMMgP07mxFqSJVbjOmFq7pELSfeWGoiA1VRS68BV0Bg+B+T86ITwPpmgeki2mli7
	wSTlm3zBFpM4Be0Mi7oQR0JgsfatZzI83E+z2VfFurrZ81DdwgF+fA==
X-Google-Smtp-Source: AGHT+IHIRtlrHZVjf/hDRjPSID8OLFIzIelRBHIadTGYyg2MUE07spOk+sYZauxSRswyF+7Ev7Qp5w==
X-Received: by 2002:a17:906:c147:b0:ab6:d575:3c4c with SMTP id a640c23a62f3a-abed0cc511bmr827247366b.17.1740581078919;
        Wed, 26 Feb 2025 06:44:38 -0800 (PST)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed205c7efsm340987766b.149.2025.02.26.06.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 06:44:38 -0800 (PST)
Date: Wed, 26 Feb 2025 15:44:35 +0100
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
Message-ID: <wgbtvsogtf4wgxyz7q4i6etcvlvk6oi3xyckie2f7mwb3gyrl4@m7ybivypoojl>
References: <20250213180134.323929-1-tariqt@nvidia.com>
 <20250213180134.323929-4-tariqt@nvidia.com>
 <ieeem2dc5mifpj2t45wnruzxmo4cp35mbvrnsgkebsqpmxj5ib@hn7gphf6io7x>
 <20250218182130.757cc582@kernel.org>
 <qaznnl77zg24zh72axtv7vhbfdbxnzmr73bqr7qir5wu2r6n52@ob25uqzyxytm>
 <20250225174005.189f048d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250225174005.189f048d@kernel.org>

Wed, Feb 26, 2025 at 02:40:05AM +0100, kuba@kernel.org wrote:
>On Tue, 25 Feb 2025 14:36:07 +0100 Jiri Pirko wrote:
>> >The problem comes from having a devlink instance per function /
>> >port rather than for the ASIC. Spawn a single instance and the
>> >problem will go away 🤷️  
>> 
>> Yeah, we currently have VF devlink ports created under PF devlink instance.
>> That is aligned with PCI geometry. If we have a single per-ASIC parent
>> devlink, this does not change and we still need to configure cross
>> PF devlink instances.
>
>Why would there still be PF instances? I'm not suggesting that you
>create a hierarchy of instances.

I'm not sure how you imagine getting rid of them. One PCI PF
instantiates one devlink now. There are lots of configuration (e.g. params)
that is per-PF. You need this instance for that, how else would you do
per-PF things on shared ASIC instance?
Creating SFs is per-PF operation for example. I didn't to thorough
analysis, but I'm sure there are couple of per-PF things like these.
Also not breaking the existing users may be an argument to keep per-PF
instances.

>
>> The only benefit I see is that we don't need rate domain, but
>> we can use parent devlink instance lock instead. The locking ordering
>> might be a bit tricky to fix though.


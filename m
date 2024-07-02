Return-Path: <linux-kernel+bounces-238235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70203924748
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 20:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1479B23E44
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 18:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8A31C9EA9;
	Tue,  2 Jul 2024 18:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDSDBeHC"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CD715B0FE;
	Tue,  2 Jul 2024 18:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719945031; cv=none; b=u2285uMgQ0vR6r8O29Jg+Huhbkx2RUPDjj+sd+em0+CH9YD1oVJtUPlXrbE/0pDuC/QD4bEznE9X8X6zinO508d5RdEQlaRottb+WRbgCgqcnXcdNE/gknr8GRSbHyIDB8BZ2o8n3TuUGe1rgGCUDC3w2PDasi+1AAGhltF7kMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719945031; c=relaxed/simple;
	bh=v38zWVxpbXA3z7mz/7ELxzwcmTVFrHRMElVOYjutQRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eFzyRuJ1rTZ/Yf+oLf0nuxMySYBnigEqgGuzdUZw2WN5KXfO9MWaSjQPiRN91qPl5C2eCKmCrb2EorcZ8eNQg+sstu5WzcemuEBItgVNktY8BhmXjDM/+9o9/n1LivPOBZpYKSEW6r9KtQPy1mf97glNshqaAVPuvTSAgrhYai8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDSDBeHC; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-706a4a04891so2982245b3a.3;
        Tue, 02 Jul 2024 11:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719945030; x=1720549830; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kr3mfZJIQ7Jlx1kZegMFzPEjcUG8jSEWEXwDyvuWDGw=;
        b=HDSDBeHC+QHnSCZVZW164cVlbFyWrw1obc2/5767VFClMg3CBs85aFvGipOo39Mgl0
         R7OQk2CI+JGcO6mxP3ymellnS54pTbeii9M5I39eAbWOi5LG5fifIZHKZxETuxDywELG
         ZQcQ1DgbSyBFanDnrobORyQ8BKe2B9OlsMbYiSj2Ly1NXVv+Yfs3/t2n/kzPjogTPV45
         sPxDaQOxHcrvX6H9uVpj7hIwr9b2Svy1HMLLxipSoFSG3Tj9dU3tsQGbe1gcO1kz4TtD
         jBJBadPC7CKBsWhSDEDq04RiADJfXqQtYqmvZPh2zE6E2IrBUJ375ZBnKg1wh8Umxbvg
         7SGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719945030; x=1720549830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kr3mfZJIQ7Jlx1kZegMFzPEjcUG8jSEWEXwDyvuWDGw=;
        b=chUeCL3Z42tEvXWG+f9Ghk97lhqqxbyKhdJ5cHJQ8dimiqJP5JfglI5nltH8yTnnHl
         LOE21mmHGeUqhDAPIbiN9tvgT7fkFXFwoC+HBfnJtsl/oLDJYeGIJx2RGFsb+PPFpn58
         Q90LitGKy18xCIK18wXooqn3B/9nMERrhNzx1Mf3LNk71vnK3QopdBD8+U7d6FJbu5nP
         3ArmpH2Bf+kjAyEk/+N/EIpKQkz3EMxBHcJaFmPmpotdfwlPy34KO+iDe/cZw98c/Fef
         +sk/HR8v2IHr7u4AfqmGUWD0b8PkIGBt/2OgzJn1GlHYetCyTLf5GBGxwFphd0r45GIs
         bB5Q==
X-Forwarded-Encrypted: i=1; AJvYcCX7vQd8t7F5b769Syu9H4zqZe71vpr2pquzs1QSFeVLHrDSliZONlQaKwDsZx1vS7/G3BU/Q3+jvMEqjxMrZwwd3plF5pLqbQPtZ0ftBwLJM8GpJhy9ujwBoGgsJAuHyRPu1WzKwK341PU=
X-Gm-Message-State: AOJu0YxY6kRMUSVChUsNNbvR4VAVDPdJKnVS2BpDxvPekqK1OfXzTWPY
	SxJS3JUeH31N1KFwihe6EkZlvOC4dy7X2UO6gZ9JkZjxtEidogas
X-Google-Smtp-Source: AGHT+IFCgejwWAtd6fIXgCet2c1N3TOobXC1HLbDt7597p1b7jILD6I7u/Xt3roJszL1DvlDCbLH6Q==
X-Received: by 2002:a05:6a00:80f:b0:706:58a8:f686 with SMTP id d2e1a72fcca58-70aaaf520bemr9482738b3a.32.1719945029540;
        Tue, 02 Jul 2024 11:30:29 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70803ecf950sm8882678b3a.113.2024.07.02.11.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 11:30:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 2 Jul 2024 11:30:27 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>,
	Eric Tremblay <etremblay@distech-controls.com>,
	Robert Marko <robert.marko@sartura.hr>,
	Luka Perkov <luka.perkov@sartura.hr>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] hwmon: (ina238) Constify struct regmap_config
Message-ID: <e025520f-b7bf-4ae1-a330-9bb737648525@roeck-us.net>
References: <20240702-hwmon-const-regmap-v1-0-63f6d4765fe0@gmail.com>
 <20240702-hwmon-const-regmap-v1-1-63f6d4765fe0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702-hwmon-const-regmap-v1-1-63f6d4765fe0@gmail.com>

On Tue, Jul 02, 2024 at 12:09:30PM +0200, Javier Carrasco wrote:
> `ina238_regmap_config` is not modified and can be declared as const to
> move its data to a read-only section.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Applied.

Thanks,
Guenter


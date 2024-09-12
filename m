Return-Path: <linux-kernel+bounces-326500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5F3976921
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0027B218B6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 12:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A3D1A4F24;
	Thu, 12 Sep 2024 12:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NZwVJlC8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DC91A4E9A
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 12:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726144093; cv=none; b=p9ESKkJZOixvu7C89B8gNaudZrVrVoqDy4gonCRhHzdUKbGFaoB6XR79v3tQLwTmYujw+6nkHBqBmwik+RLSHLTyxkN01AxmbDC5+V8BFZnt5eGm2jxz4odRwHpdWjXRNqjI5eYgJ8Owxsfl66cioB54PnZe0Z7D4zY0RfHCo0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726144093; c=relaxed/simple;
	bh=fEYiCcSX2cV8Z3LqfRf2jtY34QnJdae7Z4CSXtJ+2to=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YiGsd2j/cUNPSSf2/igsAnTzdaco+Hdi10cRLEUrNC90/fcljDcenxkrYfN09e9i4GRspL85vGX8oTjpaBCjD/W75HYLDyvPGbCqwAMzDbKjjFP9Mi17+nn0h44r3sW2vHWaLqOjJ3zg7Qdl2roV5mCTzuIMudIYeIpmPynns/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NZwVJlC8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726144090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FwLzZkmd0ZQgN84oz03gWh6XczquwyNmIfnUG06CewU=;
	b=NZwVJlC8S3tzohxc6GKUqliU2zdcKSF0PtGIqjANRcH+5ktUnjESEKyARzcC+IEh2jWpgT
	uVe1fl1EAFKNmFoCxHnX/zoBXtoFXzxtDABzZI+020fFJ6ptKNn9Ogg0QVpdBFWfhU+pJL
	E8wEzoUhgbkv0CClkCO5iCAFH4eNx98=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-7eo_CGsmOk-v8gwswnEuBA-1; Thu, 12 Sep 2024 08:28:09 -0400
X-MC-Unique: 7eo_CGsmOk-v8gwswnEuBA-1
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e165fc5d94fso1774005276.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 05:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726144089; x=1726748889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FwLzZkmd0ZQgN84oz03gWh6XczquwyNmIfnUG06CewU=;
        b=wJ44GU+imSgvCSUntIG1X8vbfD6AZQGJ8/AIUQQl+l6dV4jQT1CZTG4IyCvzpGS94R
         XKeBw8ONfVryx00lmf83g1iq4PUeG4YzcwsDW/ixZsCiDNwpBx8HX22iaFp+6WFD0Oj8
         kd59DYXoFg42MO1V1vyKy1U6qrPrbxjOgKYwcm8uqAmZXyv8wTdLj+rtGwmmvOY5/7mQ
         gIiQmsx5vOJDoj4YDJg4bXt7Xc1aFoACUAkZaZ1Gel7rtiIY4sWhCN2A6OjOPIMQGcQe
         nB9GZpC21VO6zNR3a4/c0QOM68bGG1Qfh+xOtf9NP13VbRlk7A0j2z0cBFrJ13A7dFp/
         qlmg==
X-Forwarded-Encrypted: i=1; AJvYcCV131aGShBDHC0l1nSCrqmsjhgS+lEJJK7/HS91tC+OMInjRlxIjKmCHuTYamVkAbYQ91R30wg49msmVuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWQVGl7FxmFkXPrL/wUGjKmfKqs+C2yTGfcpED2KUofRUdgdDg
	X9uLIRySXV8odsL0WvaaNxJ7MnJbw8wEfmHffFGv0GF3NdubikgQRvOBB/etWu20H8i1R0we9Et
	QDZ2zLYMYyZjAWuYrdN/tBzf5nRaQ699wYMAC4eyJfAQdH0C0y6Vyz4ZzFvwMMw==
X-Received: by 2002:a25:d8c6:0:b0:e1d:a163:1388 with SMTP id 3f1490d57ef6-e1da1631796mr1167359276.48.1726144089144;
        Thu, 12 Sep 2024 05:28:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhhzrxqO7X/GruaDObktRaDclR2OL3TS2/b52FR2g1yx9f2p0K7GyH5peWSzidW30OHXt1Ag==
X-Received: by 2002:a25:d8c6:0:b0:e1d:a163:1388 with SMTP id 3f1490d57ef6-e1da1631796mr1167293276.48.1726144087062;
        Thu, 12 Sep 2024 05:28:07 -0700 (PDT)
Received: from rhfedora ([71.217.60.247])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822f60a81sm52335231cf.67.2024.09.12.05.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 05:28:06 -0700 (PDT)
Date: Thu, 12 Sep 2024 08:28:04 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
	John Kacur <jkacur@redhat.com>, Peng Fan <peng.fan@nxp.com>,
	"open list:CPU POWER MONITORING SUBSYSTEM" <linux-pm@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] pm: cpupower: bench: print path fopen failed
Message-ID: <ZuLeVCUx4S8mn-2z@rhfedora>
References: <20240912013846.3058728-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912013846.3058728-1-peng.fan@oss.nxp.com>

Hello Peng,

These two seem like two separate patches and usually a series has a
cover letter. Did you mean to send them separately or is something missing?

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat



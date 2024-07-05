Return-Path: <linux-kernel+bounces-242833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0B9928DB5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 21:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8452F1F22D49
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 19:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DCF16A930;
	Fri,  5 Jul 2024 19:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bs7KNawY"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EE418AF4
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 19:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720206920; cv=none; b=hyhwseNg+q/X+mbDXMl3PH1T+oGiPwIVMHkMwJiCt+i7s4baxmrdAlpkmnjePo23HxcXHdNLSxOeroebdmSv58VCsL/1lTonPNr7tVBb1Y+89bZ/VoqDE6h9TazdyGMgNmbnGzGQaiYO9QhelrlJCh5USGnnJCE12pzE+rhqbV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720206920; c=relaxed/simple;
	bh=fFsTSWRXRFYt16EFU7F/MMWgOXRopt0EnIeMYLwa4Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBCWbAnVDWLin2310u5Brl8ZspIYhTHpjGPd6OiOrq7G9cy0fKP37GfW9zVjh6erjL7gXm67bme4J7DghM31uyx0JLCHTYRDxbkKtRfqcCtej59KkHCC6iIjjLVDmYtp8q16U1PROuT9HfHQBhX3OnLVoytLJogVim3GQoqOC+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bs7KNawY; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fa9ecfb321so13815805ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 12:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720206919; x=1720811719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cl5MXGKhfUGmOsZoPlLWmd4bn/0S4g8L9NNXL68GJ7M=;
        b=bs7KNawYHi4e5B02n05A4R/D6x2RLKxfIBYxQ0cXhZqRvPsHyF9mTt9ODyWWn0ldpb
         rvFSCIHbMv/qFscKzibIblxhZ4YqB61EoAgd4oVq9sFnJk/45DivXnBHIZmkAcvBZcJN
         4iE9d57gofvLpV0Hi5Z1mENWXg5RHlSptlW0WopJQquF04SbbfcCtc5Z5g97t2pCzAU7
         LT9yiPadv+JZ7PBbEElAlG4l1zbgfRzs6bR33tZYFcU/TdRBlS2lA5qvEqBn+5bdS5DN
         SPEJCqlcPyrmnyBlvlxxHXoNZi2zfq9TxFZ/gU7iLI7LfTNxYkRwp691ZkNa3HCo4Z0t
         TBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720206919; x=1720811719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cl5MXGKhfUGmOsZoPlLWmd4bn/0S4g8L9NNXL68GJ7M=;
        b=kOjcDI6FEkbafucCxh+sUpWTI5ktfcEPZEORdf1pvdxcNSXYh1/W1Vew/uJsr/e7x8
         f98r3TaHSdEssR2qfPqquAcD0cq48+E43bv3VqFYD4QIXeHjT92aVbqjitwQDUVibvKf
         z9IJHKkq+G3bK6fHkh8CtiVsWzcpvvs6DKtawMazUNF4a8o0llgqF0Gcu6tiU5f5WgD3
         HGKZIoqg9Exfuqe0R+wTRueAdNcODXwWbnP2et1oOehQQx54Mdo8maWcJmjM0mZl9sSF
         Wh3u5pIBFqZIZ/rZ6oa/Hk8kBQ5/iM0ZvU5UfNAfXX7YXydSkHXYyYI8sPw+leWWTNgR
         gv/g==
X-Gm-Message-State: AOJu0YxRcuRkgf31B8JmHsVfFJCpXf8/6rje+XiN6HyHzVdEsjLVZU98
	fVTHP1Uo3YQegpdXNlIRPrFp5mL/kwUWFE6aGlIk1dNpBjthUryi
X-Google-Smtp-Source: AGHT+IF5eqe57cz26YjRsMogC1jh4ZotWoh18rLaBS6sQfRiEM8N8JF17UrG9dL6I/mPDAgBega4lQ==
X-Received: by 2002:a17:902:ecc7:b0:1fb:4b87:6e9d with SMTP id d9443c01a7336-1fb4b8771e7mr22002435ad.42.1720206918618;
        Fri, 05 Jul 2024 12:15:18 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10e4012sm144074515ad.84.2024.07.05.12.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 12:15:18 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 5 Jul 2024 09:15:16 -1000
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH V2 0/5] workqueue: Make the PWQ allocation and WQ
 enlistment atomic
Message-ID: <ZohGRFavMKiv532g@slm.duckdns.org>
References: <20240704034915.2164-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704034915.2164-1-jiangshanlai@gmail.com>

On Thu, Jul 04, 2024 at 11:49:09AM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> 
> The PWQ allocation and WQ enlistment are not within the same lock-held
> critical section; therefore, their states can become out of sync when
> the user modifies the unbound mask or if CPU hotplug events occur in
> the interim since those operations only update the WQs that are already
> in the list.

Applied to wq/for-6.11.

Thanks.

-- 
tejun


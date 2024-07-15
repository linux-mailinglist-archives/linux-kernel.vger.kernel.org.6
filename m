Return-Path: <linux-kernel+bounces-252604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 680EC9315DD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 246AD2829FD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4CF18D4D3;
	Mon, 15 Jul 2024 13:35:28 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8753318D4B8
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 13:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721050528; cv=none; b=gHZ7CCGJGxiVfibU2MQrg4iYGyCaX4BxRLGFlZyjUWmdesdcRi6hkC46lfngpsfDgBrvK4XNgTDWByOCM7JIxZYcYFBq5K+ajh2tXxkl6fY1gxx53qJddKbVEcKD4+jcUmLivH06kztj6B9/Q7GpSm+WmTK1J93uPHOv+TEx/44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721050528; c=relaxed/simple;
	bh=NmRmO5cCpt/NqOU+S6GEDKoM92dAvUm1T13N5aoJDDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WkjntOjunOVE98QbOkSkmJbozKu+b2HPR4+YtlsU4DgVmpvwbY5PRtcGmXCsvutPjXr/zyeE9DVIOUeRr88Yz0vj1lS8of89FO8oSjQmKU6DF8U/Cy13oC2XFgvqOohgu46XlbiihebULA407Dhg5H6rz1SROS1B9/C9pkKQuN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a77b60cafecso518571566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 06:35:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721050525; x=1721655325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItPvfp+uUGeSw8Sm9Xj1mwQZhjmPO8lhUi+rDHym+Ig=;
        b=w26Z/WKWNi+Ui5vtVHZhIz1l3EK2/oo2sEB/ZJem1ism7DPC3rSQyH1dpXDyKB5U4k
         kxN31OnAOA45jyEvBbq8K1FjT9HXiUBYmUmv/CD+b6duR1ieBGSnyZuvOEZK3b5q9102
         Lc62XCj8urJmUy84aPimIkP+kjyKsjd+d4UuzUxID26IgKO0OxxlvJKVWX/IJSuZoXQW
         9TjqiVgBj3Y2bMz6csju9A4ikY55A76D4lwp6SxFe2IWygQGxV5yLuyt3AfkY+6jMsOf
         0sfXeQtuqUTTNOXUhddK0M+MP3FWDezz5Gs0H8bEwI0xgATr1qadSN2o6DLOECu0+3Pr
         Sgsg==
X-Forwarded-Encrypted: i=1; AJvYcCWSZGlCTJyqcXVoX47pihIeceaI0VTAzUQJdjhWt4duVIuICfs05l65/zdDx3yOAuE9B9DzZXTvw59ov5oU1A+ROrq2awg29Busr9fv
X-Gm-Message-State: AOJu0YzOxuowJDZbiA0hpNwdapcRw4SW8d4UJzqg8keRdEPOmaaoMt4L
	guA/3pYMd68YmsYAPvmEDHhJnRPxvttOVZ+swf5L/tdJCU+XxBjM
X-Google-Smtp-Source: AGHT+IFfJfBfBkP6G9uo2lTDF5n6Jmsys5rQHLWsbjlQugTB4TeoNZei2nvjijQBxrvsDn0iNKmnGQ==
X-Received: by 2002:a17:906:278b:b0:a77:d52c:c431 with SMTP id a640c23a62f3a-a780b6b1789mr1169727566b.22.1721050524479;
        Mon, 15 Jul 2024 06:35:24 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-005.fbsv.net. [2a03:2880:30ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7ff8a9sm210458966b.163.2024.07.15.06.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 06:35:24 -0700 (PDT)
Date: Mon, 15 Jul 2024 06:35:21 -0700
From: Breno Leitao <leitao@debian.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>, mingo@redhat.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/10] x86/bugs: Add a separate config for GDS
Message-ID: <ZpUlmf/iVgo78h4J@gmail.com>
References: <20240422165830.2142904-1-leitao@debian.org>
 <20240422165830.2142904-2-leitao@debian.org>
 <20240712172132.GFZpFmHBJHte2xS1fr@fat_crate.local>
 <ZpUSvl5eKgkLeJrg@gmail.com>
 <20240715121703.GAZpUTP-8TJpZBCWne@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715121703.GAZpUTP-8TJpZBCWne@fat_crate.local>

On Mon, Jul 15, 2024 at 02:17:03PM +0200, Borislav Petkov wrote:
> On Mon, Jul 15, 2024 at 05:14:54AM -0700, Breno Leitao wrote:
> > Sure, I will send a v4 and get rid of GDS_FORCE_MITIGATION completely.
> 
> I'm actually waiting on the people on Cc to chime in whether we really need
> it. The three distro configs we checked, don't set it.

Makes sense, thanks.

Regarding this patchset itself, what is the patch forward?

Should I send a rebased version?

Thanks
--breno


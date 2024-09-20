Return-Path: <linux-kernel+bounces-334328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FF197D5C7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 14:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94098B23A95
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 12:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B30D16DEAB;
	Fri, 20 Sep 2024 12:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oZzfGvFs"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C2114B970
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 12:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726836610; cv=none; b=AJJfeVEEzuA8zyJlyOhWOVKuLSIeN0fJCgUPBK+/zivh22AGM0z2dCOx5rTlIXYXRaul14BnCHR3KPcaMPdscSMExVoRs7PoZuxnX/2c7Xo3TJ3QAeRnHJHEbjHB0I9AzMXKr6j1BshOSRbt0DhBjZe8Yii1cS5uZtZxN2315Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726836610; c=relaxed/simple;
	bh=OBrX2SPJ/cy3El5dwOb+gA0sMiQmSueLxgklcEUTSzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRolITKZ5rJVqVj+C06uSPCAgkvCVJ+tA3qsBRC6Pis10vO0qNJLwdcX/4oIxgTrWGOmhEofTipIVdrvLGkpgfMHfd4etAoTh0HfVriawLzCVOX9YkNzgvREWqcsAC8O+z9sK7i+RzGtNwf/uolmKzeyuCc8XmfOkmVsiNi6+8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=oZzfGvFs; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8a6d1766a7so263320566b.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 05:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1726836607; x=1727441407; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BRXulz5VMdOActwNuWRT+AsW1pBw6lAA7iZwsxIHYO0=;
        b=oZzfGvFsk3XFPi7NMInD6uRvTcqOWhtIoS2C/e9/orIO7b76zlsd3qWIiOcuw0QPIS
         aS+qNP4ruhc5ATKdVXbuimW0VvO4V55w/fZRG4zm5+QVBjgwv1ii3AWoh7zkxE22rj8N
         PdkBumJ/0QMUwYaumUk7lm1LTNKmhzFHa10AwYnt27ugytjgG0pBpcOr2Fh5ntp0in4Z
         fyqhd+jzJqI8lESSZHK/Rmo/Z1qyCbf59xBVyTw7kbZbVXK2wt0dB+mRii/TIQmpKOS3
         MUHJGpHLibyc1ToxVWkSUYRGGlZnMIsxQOLX3PfYIwtFSroi3uXDL/2V9U+MaC48PWh+
         iKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726836607; x=1727441407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRXulz5VMdOActwNuWRT+AsW1pBw6lAA7iZwsxIHYO0=;
        b=h06wqtrd4tw1pRaAfXGiJxHK+C5hBfjjjf2F24TcIlGZ54w8Lk/Y+LaY7oe4d9OqYo
         IFssXdW/J76k7Acy1UNcIs0U68B3+BZBmBEz3xVs03qPv3OcAkkcGkVoCkwbSk4S9DaL
         6n6b9xc2WZ5qWmJAoHVoWNgpYEYv16MnBkXDClNpAm0maz5LFZmjFSbQ+Pj+NdsI7hlw
         keU+3kjcxpdNZa9FtwnElRcMmVy6gYeH7+WA+eynBRlO/bM4y2eyBjNFaTdKvngan/yj
         gzhV74cANpUXc3g6XXMVXA3/dPWfuw5jrnjkYIzJsWwi62pdazP5ci3Uy4c9ZxwzVq6I
         2X/g==
X-Forwarded-Encrypted: i=1; AJvYcCVSk55/1sxVbvn3T2w3fBZkggPsd1vVxlFsXMhEW5Ebj/v9VAn4/tujoYyv92VO/otAydJL2jgSQWjnGq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLrHuoT03nWqeWqojXwaDRikb8kWjTykLCbeJ3gm94D6qucLnZ
	8cx6FD1jLqv48ZOXGx/VBMGk9HFyTQAbrA9YDdlGnZ+mMv8g7bMS7Wt38cz8hv8=
X-Google-Smtp-Source: AGHT+IGLI5JfAevbKAytrlds8J1QIXfY6Ge4HV9Rl/H/KbAR0IgFYHFmb2dXYfkU7QHPZn2hH+C85w==
X-Received: by 2002:a17:907:782:b0:a8d:2ab2:c9b1 with SMTP id a640c23a62f3a-a90d512261amr243385366b.56.1726836607080;
        Fri, 20 Sep 2024 05:50:07 -0700 (PDT)
Received: from ziepe.ca ([83.68.141.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f4400sm845161466b.84.2024.09.20.05.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 05:50:06 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1srd5J-00018q-Fy;
	Fri, 20 Sep 2024 09:50:05 -0300
Date: Fri, 20 Sep 2024 09:50:05 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Chen Ni <nichen@iscas.ac.cn>, will@kernel.org, robin.murphy@arm.com,
	joro@8bytes.org, nicolinc@nvidia.com, mshavit@google.com,
	smostafa@google.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Convert comma to semicolon
Message-ID: <Zu1vfRGrBTfEAivT@ziepe.ca>
References: <20240919035356.2798911-1-nichen@iscas.ac.cn>
 <7a532573-9e59-41c6-bf57-f50cad502e57@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a532573-9e59-41c6-bf57-f50cad502e57@linux.intel.com>

On Thu, Sep 19, 2024 at 12:45:18PM +0800, Baolu Lu wrote:
> On 9/19/24 11:53 AM, Chen Ni wrote:
> > Replace comma between expressions with semicolons.
> > 
> > Using a ',' in place of a ';' can have unintended side effects.
> > Although that is not the case here, it is seems best to use ';'
> > unless ',' is intended.
> > 
> > Found by inspection.
> > No functional change intended.
> > Compile tested only.
> > 
> > Signed-off-by: Chen Ni<nichen@iscas.ac.cn>
> > ---
> >   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> A typo in commit e3b1be2e73dbe ("iommu/arm-smmu-v3: Reorganize struct
> arm_smmu_ctx_desc_cfg").
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Yes should have a fixes line, plese include and resend it..

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason


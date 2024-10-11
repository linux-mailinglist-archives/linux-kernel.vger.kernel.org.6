Return-Path: <linux-kernel+bounces-361507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CF299A90F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 18:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E57AE1F23F79
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 16:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D32419CD0E;
	Fri, 11 Oct 2024 16:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="EyLrgaHr"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4D419ABBB
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 16:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728664839; cv=none; b=roGjwQXXmO92n+4PTbORm0UdakJ36+xjFNWKaFLSqYEoVfQriCyThF4K8LzwBnO/DvKtdWKU+MmoJwNhdUNWH/UQB8W+XIDqSsoAvkH1Qx1pkd+CYo/DKhvfTJJJlOXCW9s0fQeWsloE4HPLUJHaBAbbkpbX3J7LswUU65Bzf+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728664839; c=relaxed/simple;
	bh=FovhsR+vkuZ2u0LTmZX5Esb+40u2qW79fou6tVONlWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmasjbqYY+OZF1eSSEcBgOZtb5rV0X3xNrlOLLQ70+nXizlCTGoNo6CUO0bOqudw1kjS2HH3wKN5UPeWJw1TSFci41lfIm6wmXOgjbai7YJttoZdYii+QKID6hJWvVF2mfsRgokqLL8SjuzDTao/8cFXXt7r1AwXBzf9GzNXJyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=EyLrgaHr; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b10e0fadbcso151766785a.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 09:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728664837; x=1729269637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0cJUEoNM9ligxsOvROQt2dGxSz7v+QPY1FgP+hf/i+w=;
        b=EyLrgaHrPwnnZgUgZz5xP5yJ7sPmvDsnIi2m1464rIyYF5ONoYysK7+wkvwdl1adU1
         Er+ChZLHdltqTDG7lhtVBIpKwfWiWhUKQguu132dDjGm5b9I7mJFasHWxwmg//5Aglo2
         S60/l0l2K8VpYfgincp8t2eCki2VMsf35PzIO4WKiMUGY2QhG87aG+LL1k/ptGeyijxl
         GE8NXH6VmdlCu9bC87VIpXsRTWFwvYqO5h/+aAWRdsGZ8+ujvbjjdEkbkDJBhsp49CG/
         +1wd8SK5TSuvjvtpJfsb4xMexbjqAAhBzGgDxmVCeMg+guKZBbQTRTN0HIS9vBLMeIB7
         NmtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728664837; x=1729269637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0cJUEoNM9ligxsOvROQt2dGxSz7v+QPY1FgP+hf/i+w=;
        b=GL3l4RczcowtsH7+G10f6EyIdyVc+B6tXBy49NLGUawRDGG9ad4DHkEszxwv/4Q2vX
         APBZStdwBRRMyuhApQMNRSnhBZWI3lYvbJztuUTJ0xNWzmx8bby2THUhJa/HgbTqfct0
         BKA2nJCXwXefep221IdbAUtRYpUngAGJX3rY4GDymHNLF4hrA+EM9vY7kG+g0S7VRvG0
         abAPK63W0n6OZkloX3+C+Q7Y/N4DoOm3n4gauy6/83x2JpWWdyhtpzqWVqWpLJwLJmjZ
         tzQc3TSlekZjOKSOJyaOQapMT6klHVD9yzKDaSDSMBFab7GfHg/VzuSwb+OFog9p6M8V
         NOWg==
X-Forwarded-Encrypted: i=1; AJvYcCW2slxhh+As4PomLoohlxsai6/n0gZuLWQhBJILogYmtGPewao+bCa7B8hKYPBUE+1SLrmd378GCzSjpQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxirjMotmwF3zgnKIknjyHJxtFRFzQAAssbT/q+CLbUOVrywwPX
	FkfyHjohErJmtZrJ2zcPHOOSAt9np9AArxYnpEZOgC9K1RndG8yu8KHTVj0XWOM=
X-Google-Smtp-Source: AGHT+IH6xJT0BhkFOSN3WJgaX87Y9gajn6VFuFp/MvVWlU/6es9ypp3mLVGeW7zMzGaDR2abx274ow==
X-Received: by 2002:a05:620a:2a02:b0:7a9:aba6:d024 with SMTP id af79cd13be357-7b11a3ad022mr535467185a.43.1728664836983;
        Fri, 11 Oct 2024 09:40:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46042789a5csm16697851cf.20.2024.10.11.09.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 09:40:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1szIgr-007gne-CY;
	Fri, 11 Oct 2024 13:40:33 -0300
Date: Fri, 11 Oct 2024 13:40:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joel Granados <joel.granados@kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Klaus Jensen <its@irrelevant.dk>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH v3 0/5] iommu: Enable user space IOPFs in non-PASID and
 non-svm cases
Message-ID: <20241011164033.GA1825128@ziepe.ca>
References: <20241009-jag-iopfv8-v3-0-bd4271df5b2b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009-jag-iopfv8-v3-0-bd4271df5b2b@kernel.org>

On Wed, Oct 09, 2024 at 09:28:08AM +0200, Joel Granados wrote:

> Changes in v3:
> - Adjust wording in cover letter
> - Include "_iommu_" in the prq Intel function names to be more in line
>   with functions in iommu.h file
> - Rebase on top of 6.12-rc2
> - Update my ID in e-mail, git author and my Signed-off-by.
> - Link to v2: https://lore.kernel.org/r/20240913-jag-iopfv8-v2-0-dea01c2343bc@samsung.com

You didn't include any tags from the prior version?

Jason


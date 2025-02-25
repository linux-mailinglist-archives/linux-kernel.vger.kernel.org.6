Return-Path: <linux-kernel+bounces-531592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B447EA4427D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13339189181B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B898226981A;
	Tue, 25 Feb 2025 14:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="EGgnJIZ6"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C1B256C62
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740493040; cv=none; b=DMg+t7X644WyWVQT2IqpiINTIvi+2drBlynaY7Bp0/xtMzZkuyyjnp9sadKnEdwsw30QBwM2QW1c10dEuN19TCcWKfhAZ7rdYbY8AS2Bt7uGFTzYnXqUnr3qj69gvdvgr3DlY2w1kt3kaDWS3i9Q+3tNIE+lwsF+1czPtBFD+T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740493040; c=relaxed/simple;
	bh=OBXcVx5bNTD6D2IRnummVu9gH/H+dTrk0ExjvPTnOBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/1P4PsLV/wPP7Dn7pIAApLOuJ+m1NfUhTEWrABasJU8M5RPi+q8SRsO5oUUn59NRtka8Kd+a3IU2wTzoeHAh18I90NCICewkEo1fqqceEB4doBIft+bepm4W1sqgs/1jzUnE9Qe9RrfwhhdCJAoeJTetTyf/ZFs2Y/hzjhyCFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=EGgnJIZ6; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7be49f6b331so547740385a.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 06:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740493036; x=1741097836; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GZ7PZq9etPp3tzaQLi/WkFQh7VYqZPINYGOK+qulRlA=;
        b=EGgnJIZ6nA+E/iu9F5c/s5s7p76ZrsVMxIEpe1eAEjzDKoWn09E55odVWUHDxJ8OaQ
         KCOOLm4oApxiXRSkYsK1JF8INQBvG2UVNI/6iTHfd9DCfpvIEyJLYSDzegxewg5SIidW
         5Syf/RFWiku8+CNxBsOuIGAWdbxcDsamr2tva16ASJtUSU9L82TY2E/OKJ5iA/V+s99v
         10/r6cpbkEretFgvec+pKkdnq+17k9j6h1Yr1ddeBxI6kkiy9K7h5Jc5+2Cs2dobs44T
         8xyYaMOuM0hLu+wpb5Nnaa678R8Bz6o29rdG4D9pBtspzMoyDz7JwR79Uvx6lkj42TSo
         bVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740493036; x=1741097836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZ7PZq9etPp3tzaQLi/WkFQh7VYqZPINYGOK+qulRlA=;
        b=M3mlTCQ3P03SA4J2bIIVLPlLWDf+xtQPFkXwwdcYnDt7M3uv8Ct8oczWj94JsqU0Yt
         I/SVCzEgcLaC2IsmKBbPpKDQwT0K6Te3rB+H7YCPub5VT/yNuxgyKDw/jzfDZGuv7vGJ
         40mY1rSa8oPiumI9V3UQTfbC+NG77GJCQDwbrDEv3bZEpirbbM3oOgyc5royJUfoE0rx
         gvsayDYLJrspscEIhqfBzr4Ovpdmj2AnFaZrJsHMo4qhgovVCYrmx4ykQmdEIiBNlF/O
         nGSqEVIBg2qYk8aZqnEOLfXjzCF/QAZWpXJxwuuoOioTwr1euoCK1nRc/QuMYnNUiowv
         gTew==
X-Forwarded-Encrypted: i=1; AJvYcCXnkSdd0U/25G7WMsDnDK6krMyVCnfCydz7D2bz8WKXnKvgkZXLzLNABdeeGtqIjG3Z07nbBova8TrSiwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiTzPVJlDLIvCVNMYvLzyH0bEmFXtJVGaFLAOWDUjwBTUAbTHK
	u+S83iGJ0pjy9NzJN6uu0dXmLK6VDx7scx6JgP7/pcY//hrok7fqr4CZ0aoMLcw=
X-Gm-Gg: ASbGncvODhCp4VYFPO2BHWtP7QDqcGHT4rxUMJR/69xhxyLt336MUmFqW6zp++ZC3gb
	Q+YCKsmXTWHvQz3Tvxi3HAui3yn3XAu74hIsJQ92AQnidiiM3reKq5LTOdF8n7VSg09lO0SPzfW
	fYHOTrqR+kOPSnA8z6ZhwmKH5JuUZPKfg/5HMDdbL2CRuCUO1IbBSGb+p0gCe9rluCOOH9K+f1p
	HDvUnA3fy5aO4oLAe5FdoBZJ7XtkA8n3M0dP4Ae1dAtq5VyYxK/BhNx6X7qtkTtyCQRrrB5l3g6
X-Google-Smtp-Source: AGHT+IH0VQRMAlIy3yGeI1Ow4RW2x77HcwDm9aKWUZP87RBlSWNky3yZmlg6PMNUTdEURaKUdZk6eQ==
X-Received: by 2002:a05:620a:394f:b0:7c0:acf6:3726 with SMTP id af79cd13be357-7c0cf8afa39mr2124678185a.10.1740493035845;
        Tue, 25 Feb 2025 06:17:15 -0800 (PST)
Received: from ziepe.ca ([130.41.10.206])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c23c33cc1csm109415285a.95.2025.02.25.06.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 06:17:15 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tmvkD-00000002SwQ-2lHf;
	Tue, 25 Feb 2025 10:17:09 -0400
Date: Tue, 25 Feb 2025 10:17:09 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Cc: torvalds@linux-foundation.org, m.szyprowski@samsung.com,
	robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: update MAINTAINERS
Message-ID: <20250225141709.GA545008@ziepe.ca>
References: <20250224162724.349679-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224162724.349679-1-hch@lst.de>

On Mon, Feb 24, 2025 at 08:27:21AM -0800, Christoph Hellwig wrote:
> Marek has graciously offered to maintain the dma-mapping tree.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)

Thank you for all you've done. Your technical leadership on the DMA
API over all these years was sound and appreciated. I view it as one
of the cornerstone pieces of linux infrastructure that made a big
impact on the project.

To repeat Uladzislau's words: this is sad.

Regards,
Jason


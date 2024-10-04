Return-Path: <linux-kernel+bounces-350306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8496990333
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 14:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EB951F23659
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 12:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4915D1D4327;
	Fri,  4 Oct 2024 12:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QbmqyC66"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C7C146589
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 12:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728045827; cv=none; b=iCiY46do+x+8k4kzvbyPnNrVHA7sRRxCMJNEmxqK/PsF/xCvL2KFvjX5DqkY0ROhz5U7dyXH/OWFRIRopzvKt764cSR4x1RlZHac4vIfn0+NkC2sGdribeCAOmLPGcxXFvUsSHumJ7KI5kYn2wAgi7kVvSfvVF2gsugHXvKX0eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728045827; c=relaxed/simple;
	bh=HSOAqw79gXVAVkv8I96SO09KcBqBwdwHMfyZ5HwM23M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bn0odQgBN7PHeFqqyNlYTzaIy0w2e8rMSZdiTj++xndRhhfD7y1Bsjrf7oaBJXP26BKFmhfgoulVVoFtsRcJl858rnDmSC+qX6HoDQalcfJ8orsAmgFcNJjlncEm38TqvvdV3APfMQNG0NjkHBAcbvdwlcAbHRxMfu1HxCWGbR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=QbmqyC66; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6cb284c1a37so17086706d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 05:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728045824; x=1728650624; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HSOAqw79gXVAVkv8I96SO09KcBqBwdwHMfyZ5HwM23M=;
        b=QbmqyC66Zz5xIyvVDi2t4D8YAbb6m7Fqkp4xqwFWPq0MpvWYec+rZw8y9qR/NWMdyH
         dARbeTTIIRM9PxVn5s0aXryCPd9i5sPeeLtls+/45wlKjP6Ys6Rv3K9+sUT6mZNawqyO
         pQo1Ts8Swis+P+h7FTM4TH4oDfjWEXrh1CV/0dSzd2ZlLLvLCXLv5v8wIY++VdkuKTpY
         PZxt4s87No8yESTH5MUVwvd+ISXCIc3UDr7IKUwu5a2cmAjnxashQzL/YS3RZkO3fJfh
         WzNWorlkuSV4d/43oWUYZtFeik+BPsQfId928RNCBUmOC2DXoqIioUoRonikTYXP/00j
         w5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728045824; x=1728650624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HSOAqw79gXVAVkv8I96SO09KcBqBwdwHMfyZ5HwM23M=;
        b=mcyq8RDmLptsy51/TMwbYO5JdPWuRK7B+I6GCSv2p8p3brPeVWM6ZIwoslFbb4Qwr8
         +bNNBtf9RiyD5H5UCRDm6DobUGGufMWiiHGFpAx5xwMpzdT6dW7qnTE41VZlleuafCCe
         wAacv9A/j+CYDNYitViAfDPELQu2R7lzymL03oxfr6kToQNyJB/tA0sN2l+qalNsg+Cx
         yANTtXAG4v80OvknsFkGUnwwtId/pztvLIEwxbZmoY+WOBG+/X1AKZKJ8IwYSuP7pZUf
         FWsNEtGC+Db3VohxPzl/eWz9iIyrMYdNbd3Ws6JX9OBvz2Jx3CG6VLOF6BAlkhAulIoy
         0gEg==
X-Forwarded-Encrypted: i=1; AJvYcCWKTZlh8YOuTIFArrKUEKxearbe53yw+Jx2qWYN/w89ZvDF/jJKKtGYcWfTt4kTmdAj0R8lOZBHSZjA7K0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2s25dZZ29VCn+n6BIkP1CHVLz0gBbWKjaEa//Se4ZEjvz28qn
	dRkYX8Rm4f+S5VnnwwQTD1EieJvQCdIzWiGs9Nd2kWokhPyGJFjyJqkzdra12hE=
X-Google-Smtp-Source: AGHT+IH+lBEw9Gy7ze1H4cjY01Q+qaaLegOnnDxsIEJsjc592NIky/t8xlw3yrAV1RLwJUr+c1mMjg==
X-Received: by 2002:a05:6214:398a:b0:6cb:2565:3f5f with SMTP id 6a1803df08f44-6cb9a490b83mr25471536d6.51.1728045824196;
        Fri, 04 Oct 2024 05:43:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb9359c013sm15335776d6.18.2024.10.04.05.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 05:43:43 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1swhep-00CeVI-0I;
	Fri, 04 Oct 2024 09:43:43 -0300
Date: Fri, 4 Oct 2024 09:43:43 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, james.morse@arm.com,
	will@kernel.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] iommu/arm-smmu-v3: Fix L1 stream table index
 calculation for 32-bit sid size
Message-ID: <20241004124343.GE2456194@ziepe.ca>
References: <20241002175514.1165299-1-yang@os.amperecomputing.com>
 <Zv2ONA2b3+kMAizm@Asurada-Nvidia>
 <1c9767e1-4d05-4650-bc14-65a18fc63cc2@os.amperecomputing.com>
 <Zv2diJDU6v60hKtU@Asurada-Nvidia>
 <20241002194004.GT1369530@ziepe.ca>
 <f28cab76-8030-477a-84b1-461dc02451ff@os.amperecomputing.com>
 <20241003111603.GU1369530@ziepe.ca>
 <43c2227a-71c9-4cbf-bfec-5a2fbf698f27@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43c2227a-71c9-4cbf-bfec-5a2fbf698f27@os.amperecomputing.com>

On Thu, Oct 03, 2024 at 08:31:23AM -0700, Yang Shi wrote:
> If I understand correctly, the check is mainly used to avoid the u64 -> u32
> overflow. This check guarantee no overflow. If some crazy hardware really
> requests that large memory, the allocation will fail.

Sure, the kalloc will print a warn on anyhow if it is too big

Jason


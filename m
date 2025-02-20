Return-Path: <linux-kernel+bounces-524470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FE8A3E37B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EF18421F6A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7885621421E;
	Thu, 20 Feb 2025 18:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="vdCfuiPF"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DDC212D86
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 18:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740075033; cv=none; b=HfyGWqim+WvMKuV3T95HL0RA+LTDQAFitOycsDTwOeiulAQHL7Sjs8NEt7cbj6LEfGY1hDW5qkDjMvjncY7zPFAq4PAqwBlJT3kZcUE1y9pkatniewLofIWwt4GUYh3IQNQHZ5osH1BxPSRVB0xI/pOLjgJOqnXCFMYm7SW3LUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740075033; c=relaxed/simple;
	bh=BnzPYwD+/ACHetckWkU9U44xhKWvoL6J1y/pBIlclcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nA4tWz2mozcx6gyImsOQCxBduS1esDFM5LuTmIsa0620A2jDPXrecAKP9pAKODx3psxxoMeSxjCplLgzGJrt5RljZwtlqGqF6mjzJTjhlbAb6KM17tL8JF/M79IAe47v6ZIQwJLFxpp4PaoPDE+NED57Mwb9FpXKE6rudkuZ3jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=vdCfuiPF; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e6827984b2so13368656d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740075031; x=1740679831; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DgVkGs/GxKF/u954gQrsv0gFs1KRDgFhv4TSAXX70kw=;
        b=vdCfuiPFF3G1sOXx5mhTbu/WaPXAukeFaKGmFzoG5tOnqDlE2dlWYNEbBqolIXO3iK
         6yahsso3j9N46RjDzAItfbBXQJQLAH2WqszBeBoX9NSKOzupdHE8Mj1SyZRUBPgv1FGF
         o1Tpb6d/J3gIyRP3KawmvGezipt+e9QgMpzvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740075031; x=1740679831;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DgVkGs/GxKF/u954gQrsv0gFs1KRDgFhv4TSAXX70kw=;
        b=qk7lvMzJJNCkuj7F+31NKdAEqUbeTSQ6aLzWXUUTYTytNs/F7Yldf+MQswOJ77NUaG
         nlQsNda69OCx6UI1GuVk2TJkco3UUDbVgQ7SUnBdsPtbfJ+odxzllWd2TuBQ/jBHwvQX
         0cQKU3T63L9zMC7WE4HvfgoBMTo5s23rL3dNPxLfgi9rHrnEt9N4F6lZ6kfbkKmz4hVt
         gYWFMD6UPrzuGHpl2uX1lMVmpGvcTJOvhi2MzlZJNrsO+7vfdJH078g0PiatB5+zcM+l
         MEnTjvr2TDJoLVX7i1Db9dIEw/M63XlpsentU94CpAq+IPevzTc4g3fps9Ho84pqPfvU
         MquQ==
X-Forwarded-Encrypted: i=1; AJvYcCUK2NSJvATWIGXtQiShsLTjgxgDwn1oV3DnLQOWTTCQygY30CoD4/jKtvPl10j3WoUh1rPlWOCbHR0GOeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU95wrMqCXv4t009c8C+78PKcCaidAlC8bTOos5kvpgqiVmtFs
	jQtBNzhNh85+9vjguygA/Ftfs1UA8lu70XYSebApUcUiFZPydH2GvmjtakepWko=
X-Gm-Gg: ASbGncvhYydGa4Wh/hofgz+Yw2bJzj4Q0lEpjVWAHbZATgxEPm8O0/0KkUrs0e3XEwa
	9EY1trMKd2s8PrPJagCozrm4ivehOEDR6kWjmaEOlFKPxRS9hI2GtIPlOYnrqG/l4tG+X/Ygl6C
	fCbEyupOp87rC1kYZR/90q4HzAVugvvDCUMpERcfkTN2NXOcNiZNIp1Rm6HiKA24hXyd48iQur8
	bvy+Xjji7nicB+IiZPX3/oRexM+A47RTs81t07YT5rYxAdyVVkeHmESwd4AzdM8ou/P++c2X+MG
	NCPGWnqka1FHqhaZ5SPNZ9bKFr4PV1HVPvD3tbKmOYJxdP3aXUCccw==
X-Google-Smtp-Source: AGHT+IHin+TZaZZxa1YH+V8R25QIutVnpEkZSx4sZ3X8M3ZLt2shSA3GG+9KPvp3BZO5O4MqkgnygA==
X-Received: by 2002:a05:6214:c2c:b0:6e2:4e1a:bc82 with SMTP id 6a1803df08f44-6e6ae976a48mr1320856d6.35.1740075030882;
        Thu, 20 Feb 2025 10:10:30 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c09ac82577sm529159285a.39.2025.02.20.10.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 10:10:30 -0800 (PST)
Date: Thu, 20 Feb 2025 13:10:28 -0500
From: Joe Damato <jdamato@fastly.com>
To: Adam Young <admiyo@amperemail.onmicrosoft.com>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>, admiyo@os.amperecomputing.com,
	Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH v17 1/1] mctp pcc: Implement MCTP over PCC Transport
Message-ID: <Z7dwFKs-ysnJ2Rs4@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Adam Young <admiyo@amperemail.onmicrosoft.com>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	admiyo@os.amperecomputing.com,
	Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
References: <20250205183244.340197-1-admiyo@os.amperecomputing.com>
 <20250205183244.340197-2-admiyo@os.amperecomputing.com>
 <99629576779509c98782464df15fa77e658089e8.camel@codeconstruct.com.au>
 <b2ab6aa8-c7c7-44c1-9490-178101f9d00e@amperemail.onmicrosoft.com>
 <1b38b084be4dd7167e80709d3b960ac1b4952af3.camel@codeconstruct.com.au>
 <8f5a1f2d-5ff2-43f8-8964-a992d5554db6@amperemail.onmicrosoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f5a1f2d-5ff2-43f8-8964-a992d5554db6@amperemail.onmicrosoft.com>

On Thu, Feb 20, 2025 at 12:31:21PM -0500, Adam Young wrote:
> On 2/6/25 19:30, Jeremy Kerr wrote:
> 
> > Hi Adam,
> > 
> > > Is that your only concern with this patch?
> > Yes, hence the ack. If there are other changes that you end up doing in
> > response to other reviews, then please address the spacing thing too,
> > but that certainly doesn't warrant a new revision on its own.
> > 
> > > What else would need to happen in order for this to get ACKed at this
> > > point?
> > It already has an ack from me.
> > 
> > As for actual merging: If the netdev maintainers have further reviews,
> > please address those. If not, I assume they would merge in this window.
> 
> Should I resubmit this patch with a title that includes net-next in order
> for it to be picked up?  I can see that there is stuff being pulled in and
> net-next for 6.14 is at RC2.

I am not a maintainer and I don't speak for them, but I've been
following this submission so my guess would be:
  - Fix the spacing issue Jeremy pointed out
  - Include Jeremy's ack in the updated patch
  - Submit a v18 with net-next in the subject line, an indicate in
    the cover letter the two changes you've made (spacing issue and
    adding Jeremy's ack).


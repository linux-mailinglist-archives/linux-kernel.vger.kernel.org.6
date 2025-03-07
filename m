Return-Path: <linux-kernel+bounces-551368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F70A56B90
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D965318952C2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F7622173C;
	Fri,  7 Mar 2025 15:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="AO77NOoX"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F5D21CC7D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 15:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360382; cv=none; b=M3pnyGTSz3/1wOontkH2Otrd4L5sji53gz/x+SDp8GmA3SeGPOB3vuW73zn/ce9FpSblOwdxg6oNrKp0Q5CE8Tm006ZqVPqQBIqyNbnsB9kbhZ5VDN3oH1sqE6LHWkM167CJsN/SI3dxH1BPrlVPRqnFLsXUmh0HECn0kdbuzZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360382; c=relaxed/simple;
	bh=2wMX+dMAk5OZF+yCTsbRVFzfhhV1PUCth+hni04YDPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIYqAgFIbqcLZqFQgeIVHzzh29ZRIA8ec69IJhglphIopaKndwd25pniT+KleNUiqPq0jiOf2OawR4+ZoAFc1M6L9nAnhnD4ug9c2stAN+49RwpfsIIGdEN5amdUUZnnsO3y73ACl7R7uLG9QpevH6kIwI9nsFvWJ1FXbtM2Jg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=AO77NOoX; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c08fc20194so349950485a.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 07:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741360379; x=1741965179; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vNr4ntECNtNIMvxVKv6TWdyQSFpn2hDLZaLcHO+bzIY=;
        b=AO77NOoXJBfPlExQuRnKEaWsOzBdXm2Axv0DEqDZChBcM3Cl2RHWDm48r1SUg01GO8
         qLA9aY4bqaF+sx3JToR8HCG9sNxqQ38GvYG8HyaEl/TczLRk3CedFkH5Ke3qMq75M2s+
         iaUzR4t7shhI5Zzm5Dvs4Dq7AOPtUUHPL0E+ybyYgBhS2n9R9jgJGfFlV2Gt1vVtDWkT
         Q+6GEi+6O/GboV+iLJMzY4RLQDFMBBIiMoYp7f8zknCVd65Mb1gDrCWQd3or8Ui/8Li0
         KKAeu3Q6X3z1boDBxJuogIwhJPIlS+cKhUmmi37W2AbPAdt043GBaVMG98GHvq2pkRpJ
         9FNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741360379; x=1741965179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNr4ntECNtNIMvxVKv6TWdyQSFpn2hDLZaLcHO+bzIY=;
        b=L0tOogFgY2i8ruc1diZidpDU15adfdjpY83jjPFshn2BzaVTJljURHv/rschQe3+vl
         PKZw53pOwx7fIclOnO9VYuOyvz2Hk3OzkVCAxqR27kI1TyhohJyiYBoJmeyZSlMuB9nF
         pMQzpzwcwmlA5W+jTBFjOSuUTS0somBzG362EzcBShuo6kGxS6R1msiROh6AysVQlVfk
         +Bj21FR0vjtbBHqsp1/5NNO+45H8dk9QA8zwtL6m8cOsL331YPPYQP7WbAqI3rYDu7yl
         REpZ6kxe1qtiUgAl7Qi/Ef+C2nf0rJlBD8qCAL8LPJ60aMKYF6RoLNU7hiZHeJanyITh
         +B3g==
X-Forwarded-Encrypted: i=1; AJvYcCXSFnZ6oT3EIXj7g9YCNfIQ6faO2+/Jie3WVcUNp98pktcPFlUtUSo0x6i5uU8m3RS2mR16jlzKgn7htHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCOGgmweMevh1EVwHLAAdxbPSO0O8a9dGvnpCNdHaZoEzBa/dZ
	RzDZOpbPl8qhzaFoMPKK10zQQySYqwj99u5za6hUtPgWS30WPnkFkcdXFXJsGLQ=
X-Gm-Gg: ASbGncsHrHZm+eKQyBg7PsUwzQ8O94+o/llrXari3Cf9tK6w5PubbGFaG80PkkDQ1Jl
	MtoFmKhGUfGY6BFNlADE79MAr8xXV3qQA2KoD3G5pO/lw+NaxTIX79vSySnqC5GUMIhC1tickHo
	KBVT4XMhUQhRtyi9MI+7ogBKpqSz/hJLgc1cWIUQeCE7a9x/S61i9tTfBOJhvD3Cw/nRzKGPC8Y
	D/OTTbx8lWzF6TTEpm8J+6AqM0ql5wKgbV4s856QdxQdZJlc4rz5ycTITEqH4M6nphP4Dt0CVf6
	kQd6LK4Sl2d4GJrQweuddjtydtEPKeVnlKNM4FCUGX2ambpDWiKQS4ak01dq0immc7lk/axLmRg
	OLFBDolIXb1qnSG8Bk4J3I8zh364=
X-Google-Smtp-Source: AGHT+IF1GDg63LmfyEarUB00FtiXShcOK8KVLiCcUDagJpfOb04hfBNYSrYPbaJ5e8IJKwahRj+kBA==
X-Received: by 2002:a05:620a:8806:b0:7c3:cd38:9be0 with SMTP id af79cd13be357-7c4e61ec9damr536785185a.56.1741360379462;
        Fri, 07 Mar 2025 07:12:59 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e533a9f9sm252426185a.23.2025.03.07.07.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 07:12:59 -0800 (PST)
Date: Fri, 7 Mar 2025 10:12:57 -0500
From: Gregory Price <gourry@gourry.net>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM] CXL Boot to Bash - Section 0: ACPI and Linux Resources
Message-ID: <Z8sM-W1F6-TIZcGa@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z8jORKIWC3ZwtzI4@gourry-fedora-PF4VCD3F>
 <Z8j8bZ5TS+gDV8+M@phytium.com.cn>
 <Z8nWobZXQwhtE1nK@gourry-fedora-PF4VCD3F>
 <Z8pX786s+1DQIMDy@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8pX786s+1DQIMDy@phytium.com.cn>

On Fri, Mar 07, 2025 at 10:20:31AM +0800, Yuquan Wang wrote:
> > 2a) Is the BIOS programming decoders, or are you programming the
> >     decoder after boot?
> Program the decoder after boot. It seems like currently bios for qemu could
> not programm cxl both on x86(q35) and arm64(virt). I am trying to find a
> cxl-enable bios for qemu virt to do some test.

What's likely happening here then is that QEMU is not emitting an SRAT
(either because the logic is missing or by design). 

From other discussions, this may be the intention of the GenPort work,
which is intended to have placeholders in the SRAT for the Proximity
Domains for devices to be initialized later (i.e. dynamically).

~Gregory


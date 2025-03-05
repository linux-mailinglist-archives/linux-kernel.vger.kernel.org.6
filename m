Return-Path: <linux-kernel+bounces-547563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6217DA50AF1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35A7F3AD8C2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3AA1A9B2C;
	Wed,  5 Mar 2025 19:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NVRO0vNM"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494B62528E4
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 19:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741201353; cv=none; b=WrymwktxZKAEZLqja6DtHBG0HYaqc2QEQoWvyH2NRC2jDbtO56AmPEGsfQM3urW3mq2ZCxxY8U1Ot5Q1XlBdfP3VaJ7iaIGvb5BKP9Bl8p1kavQc/x8bdQgTrpDjZctfg60XfT8JCX7jKC/7QV33FNaFfAXrjcYvhzCms1zh4t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741201353; c=relaxed/simple;
	bh=PImNvEb9R7mU674MFRkVo7MQticSDFJlq5WrSF4+QLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tzu+FI0b0s49qZNw+39qlFgLZSNilB89dHS9PZzhwy6lY7IH7zD+ag18YDt/TESHuaLfoIK5K3PEHg33iQDptVAATzNOasUPXKct0lPQVepgdXEsEx9Mkmx0Q18bRTK1eG3hhGNO4UsqF9/XO+AaftwrsxyGot4Edo4lV4AX1Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NVRO0vNM; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e89ccbbaa9so48924006d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 11:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1741201351; x=1741806151; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PImNvEb9R7mU674MFRkVo7MQticSDFJlq5WrSF4+QLo=;
        b=NVRO0vNMMP1xb5l7yHeeZHtiu30SNJmMnG5TGDpZzC2ZPgqkxt9C1VlqqHdoYF6F3b
         DXmaIBjL/zBVH9EvOBV7G4+KhXZoaryYs4+h66JHvkQFCx2Dh0TW1xHDhqP68mgosR+H
         Ov7+ccF/9aXpTP26/fHZlJqXJS6u6zS/NToVqd60eZ0Bnx4I+3Lf/zGYiIgcZzIesIKv
         moUJEyAWUa46Ak5Ww+ksWe/M9kc/dWNFU2rkeuaEZysHnKsje4l/Ylyi7KsE7T7X8a9A
         3kT6BmnnKtxT9Scl3i403/D7KuYC3XRTJB4/DIDwNaGl6D7vxQb6encGf+V9KOboRA5Y
         19nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741201351; x=1741806151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PImNvEb9R7mU674MFRkVo7MQticSDFJlq5WrSF4+QLo=;
        b=Ig09Q/VXOjqr1oOx0XTIcQnj3MvdeGRewCfcGmpIKMcNVJngAB7gNE0BtcgCLvXqsr
         jUpA6/ZtzA2YKSV1fJCDk8HTBefH9OZowQgZb56ypoIYnAK6q47wGsU+XhdN1cGHOJru
         6vSYhsiqCLG1SyggJXGvMPXX5vXRfgF9Ui/bpIqSNuIrSBxKhkTGmNaHfRUcJLfMSLco
         uVpItbShzpsDQWDck0pnXEOOt0cYJyJih1Hrbzt3PWT3YQePj191RTZHI9ztVaneT8uZ
         sWxZ7GRwQZs6oSSnxY0jNRQQcfwednxiyVtr0ECiHsKdqyY0J4AlqHGb4KVXSCb6ISHs
         njwA==
X-Forwarded-Encrypted: i=1; AJvYcCWMQY+0qNXx//3ZupLrj3MjKVwqThDGZ1Ddxi16cJ2UqApkeNMNKMI36ZUkB4Kxr/WTuke/4zt7JYZ1mWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8AW7n6USpAPKN/i59L/pcOkIR6ADC0U4S+Ugha3NJ8wIdAd81
	ZUY7Q/A4IPAGAUQd6wW3lYWV0fOoWn5+ydxffWhZTRNgRvxqTnr81X2sgexobZs=
X-Gm-Gg: ASbGncsW2PZIHrH+kCqM8mc1p2ZYf1QX5CiLJSffxpmcSI8VB/BvwtcXBnSjg57LFuM
	WfZlCWDj/fXSbhV/qMkAlfo0e+u/gBxVZ/GpvfSjFSwI8KIokaUS/QRGIj37L+lYbCn40ZqOsGZ
	1lBVjDyqNrEzWhTa/mn2ioUFCm+CtW+FBXTiqcufHpzAG4/rHdyPq3LZeK2bixCDFsgyxZmcwMU
	c58uPbAUQKN/axTai90MAEznFHq67VQDo0ESRGEQnmUIYu1Cg8hQ1hG0CvEn4n39EGFaA3b0HMy
	3Ek4YfahEDJvR8oMV/yWYC9wOoxHEBAZ2wcDBy38P+CnII49q19Qwedx2wuzEelUmB6gnNelwzG
	G7sKPnD/ng7xqIcRyaQ==
X-Google-Smtp-Source: AGHT+IFj/qwQTwKG8SNNtgVxRj9GZyBrMpWQIs1ECNvXkzZ0QEhM4dpXu10vspXzdcAPMQORADqmUA==
X-Received: by 2002:a05:6214:c48:b0:6e8:952a:240 with SMTP id 6a1803df08f44-6e8e6d1366emr58222716d6.32.1741201351058;
        Wed, 05 Mar 2025 11:02:31 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8e885f85csm11121396d6.100.2025.03.05.11.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 11:02:30 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tpu0j-00000001Ucp-3R2H;
	Wed, 05 Mar 2025 15:02:29 -0400
Date: Wed, 5 Mar 2025 15:02:29 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>, x86@kernel.org,
	Dov Murik <dovmurik@linux.ibm.com>, linux-coco@lists.linux.dev,
	Dionna Glaze <dionnaglaze@google.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH v2 3/6] tpm: add send_recv() ops in tpm_class_ops
Message-ID: <20250305190229.GC354403@ziepe.ca>
References: <20250228170720.144739-1-sgarzare@redhat.com>
 <20250228170720.144739-4-sgarzare@redhat.com>
 <Z8Jmps6AF_geaHUw@kernel.org>
 <3p5erujbhxw7ozdnfpmresv3dqdh2xszolv6mh4khkagoy3wit@ow5qht4keh4h>
 <0e156883acf95d31b9358831550d6d675e3ce4ff.camel@kernel.org>
 <Z8dg46Mj81Q9Z0WV@kernel.org>
 <jkr5z4thb55gs2jcmtcfipgg6p7z6ikhr6etd6l3nqpf723hf7@3fns3z5cjqk4>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jkr5z4thb55gs2jcmtcfipgg6p7z6ikhr6etd6l3nqpf723hf7@3fns3z5cjqk4>

On Wed, Mar 05, 2025 at 10:04:25AM +0100, Stefano Garzarella wrote:
> Jason suggested the send_recv() ops [2], which I liked, but if you prefer to
> avoid that, I can restore what we did in v1 and replace the
> TPM_CHIP_FLAG_IRQ hack with your point 2 (or use TPM_CHIP_FLAG_IRQ if you
> think it is fine).

I think it is a pretty notable simplification for the driver as it
does not need to implement send, status, req_canceled and more ops.

Given the small LOC on the core side I'd call that simplification a
win..

Jason


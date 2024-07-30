Return-Path: <linux-kernel+bounces-268161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4514B942105
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F155C2817FA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2D618CBE0;
	Tue, 30 Jul 2024 19:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aa7lTzFP"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5513FE4;
	Tue, 30 Jul 2024 19:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722368895; cv=none; b=err9MNP8iIsD7IyfMopjVVifGrDsDMNFGYaAcpetVHNG2RBy3/XuMb21heE9/m6SVo2CQ84UfAqfSdILf+m39Q3IqverTe56qmmRu5sK4x8u0FWxSEl6/rBlxenHMyutu48n2ADn/F+3lwIhQs96udPZ1/ibcJd4JFNVR3I/jH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722368895; c=relaxed/simple;
	bh=ZAmZIWIEhCIhmGzzpDJ5vhuwis2cxS/mWyQQzibV4UI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhoX6reUQF+BWMpoOap9IWnNLTuihwPgtzH8In++zqrtwttWIiXNNqzj2/kbaPOLkzgKD4deByHVN9LacZ4zJUKLR2GcW/ixFxggGvVoF3s73RFF9WKp5IN5s45Lus417MwSVUOcn+J2+jcwZwpf1FBYr/Dw4gzuVAGnhBBzQXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aa7lTzFP; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70d153fec2fso3859757b3a.1;
        Tue, 30 Jul 2024 12:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722368893; x=1722973693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=diWdjRqXEGFSY/WPji21hwYK/rR5ogxIGLkpnjqpNBg=;
        b=aa7lTzFPV1igyrlXeutNAnfvjcQR378cx/vSK6IbrOUBFynBwAu03MKY7KcjWmp/gm
         3izFvsayDd1RAcJDlsTW9XJrRu8px/sQZg3CRArA7z/XsND9W+fOdP+yTaLtwKMv+tv3
         IHFquX33nAd1T+/mopkXhH7T8sBjQHervkTLfJoU+8rqgH5gmO3Ofq3emOQyluyp8iZO
         N5ZsqucTglkhQXhT2EWhK9azx5rkk4SgJnokjT2hUxunxKyStsgXvvJ7g6ulnRgmtWcf
         9CR9tknlsr2uQhZOJyb3kTTDG4CD3pMBFyYFEqhBJEyuJ/F+w45CvrZ9TWnUTIBjKFQR
         qAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722368893; x=1722973693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=diWdjRqXEGFSY/WPji21hwYK/rR5ogxIGLkpnjqpNBg=;
        b=byfzhoppI4OJk7iVai+l3ZOmaQ3sErTQ0ae7HNCyGWaKErj/60kNodxD1hah0a7TtW
         TcLHAQD+bfUJFiFgN1MhTOm8yev9mBaX/ix+dzT5jlvUHOkOUfccB8T3t+xdxPMaIUEd
         svvJ1qQPxnUF/HMYrWiY3bLCLW0kAi2jUXmUhrU5LUbA0b/ua86pr+dWJdSkKFFH0BhR
         r5BzvLkk41LuReSPT6S44i5ZkjBxm9ip3DrRmYvFg64uhVio4wbPWQRpge3hE3eaotmX
         cFg4Ov8UrEkcPYVPn9si+4DPeQfyH0/d3gflduiWj0RgJBDel9C090AqzmSbQaYRhp8g
         3uqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVgAUgtxzVRu4OB7WUEBA0MFBq1pJLdb7/uiN4ttLVEzxG4ZtIv7g70sWko8sytMdVZwlm2ihHeRdEYxXnxumu5bujI6Pkwlb60L8qAcJpfZ+XoqKpJG3qRNc5PkAyxpaCRDWPF+ks
X-Gm-Message-State: AOJu0YwGz0Ox6chUfntsMp9/TSfrq9F+uBRQbp6Tcr61kCln8gYMBQhx
	ifHAkEGFjbODbI0jpLEYT0QgH5SDwccQxbe53KL7PrfhDtImbOBxPRfTvQ==
X-Google-Smtp-Source: AGHT+IEuE+v1RAf30TWvn5kOSVZiuxBfX4ApHVK6pNXfnWWbJxVLRZLZzL5xRYgjUKFaiVkdCfELJA==
X-Received: by 2002:aa7:8888:0:b0:70d:21d9:e2ae with SMTP id d2e1a72fcca58-70ece9f42f0mr16181456b3a.6.1722368892855;
        Tue, 30 Jul 2024 12:48:12 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8a39d8sm8823308b3a.213.2024.07.30.12.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 12:48:12 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 30 Jul 2024 09:48:11 -1000
From: Tejun Heo <tj@kernel.org>
To: n.shubin@yadro.com
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, nikita.shubin@maquefel.me,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@yadro.com
Subject: Re: [PATCH v2] workqueue: doc: Fix function name, remove markers
Message-ID: <ZqlDexrLVIU8pQU_@slm.duckdns.org>
References: <20240719-fix_doc-v2-1-a5cbeb46e0cc@yadro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719-fix_doc-v2-1-a5cbeb46e0cc@yadro.com>

On Fri, Jul 19, 2024 at 05:30:16PM +0300, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <n.shubin@yadro.com>
> 
> - s/alloc_ordered_queue()/alloc_ordered_workqueue()/
> - remove markers to convert it into a link.
> 
> Signed-off-by: Nikita Shubin <n.shubin@yadro.com>

Applied to wq/for-6.11-fixes.

Thanks.

-- 
tejun


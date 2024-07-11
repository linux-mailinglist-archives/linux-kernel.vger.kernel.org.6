Return-Path: <linux-kernel+bounces-249846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FE592F0A7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 23:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3C6A1C21AEC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 21:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C21619EEC6;
	Thu, 11 Jul 2024 21:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ps4HShvB"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F1315533B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 21:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720731969; cv=none; b=ao8CBHfIePkUIWtspdwM9hvXbkuxNhW8WeVKVm4VxWVVb8ugMeASvAqb+cXyJmODaSPXW14JRjJuOd24YWYemRoHBBdYSApTuS+Mow9og6/mmdzDZCy59dpm/q2khTZMfDQLhoHqjbN+Y91eaCBFF4P17BKUDFLz24cRmBHtzkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720731969; c=relaxed/simple;
	bh=Nx/AxM36fpHvMgG+8HA/vzGe51U+wThqDVz8KLb7ZOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPK2cVZUmqvMpxwxJ/gNLQvwqtXkFAPIprV/CSKV7OHYcNT0dK3Re4cQ2xcA9gy2Bt706/5P3ziAT0I6uWzOpkt5aWNAOdHS9PEZ49dGjF78X2qvkP9jULu70Gd7q/HRDJcr/4C7c3SehJ7SRWtR+DWs0cIjanDXyemxcSimMuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ps4HShvB; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70af3d9169bso1288731b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 14:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720731967; x=1721336767; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PYiIUWDkAPciWMZf4h71Th1E3BZWOt3UHL7ervzA1Yk=;
        b=Ps4HShvBFqUMs8cFDd1WBZTE4aKiKYsW0vhsA1Fi6ocVWuPxPdUUI5+VPOza8jvGI7
         iAnm2ygYGtB+qQrFvaku51mfoJhNxCFiHDGA5lW4QRmEA7aTsK7Hy/BflatiVZZ0RwHb
         Q1gwW71piBWYpMvlGR9ayTMz//KAGG7e2ZxEcjN3/eRFVn0Wvtm2a8ry4bqY+8zwrsNv
         YC1qADRJtDxnXBC6M4S2io5shxMGsiI4qxYPNGMb81HuS6LM9AlHQSRmTeUtlrTYeqYm
         dwIOiOfKAHTr+DGgPTuOrLnkuz1R2homeIQqbIL6GtXiFTM2nBfYd5Z8Ngto5QTN0MWa
         yEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720731967; x=1721336767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PYiIUWDkAPciWMZf4h71Th1E3BZWOt3UHL7ervzA1Yk=;
        b=gmcLDwLrkMT9SymE5wIMBOmHvBesHUSsxkau4m+1eBAfsIPXa+5l6q35mRodV3b5zo
         BiekEbX/3ytzethRWtIJ3aS/MhC3YHarklVP424tw2inpdFBVbld1xh5Wtu/HahPUeOE
         ol9yWCaIYiW1JZ50mDZu6+vyuoyWbKIgrFWApHSQnXaWa3JOEr4hTPnSrmxVOQgc8vZj
         SwIfnxv/FaHg2Z2a88wzF+v6fmXKM3s90mN111Y81HdkTrHzldZv1QHm9dRP4Jmhp5c6
         X91/zkxMqUtcMFnKQARAVLrJgnVs2Te+0yasS6CRQ42d5OzLi//bNtZ8vuyf0hBdaA2q
         GYyA==
X-Gm-Message-State: AOJu0YzyU3oGZwS34mlWsQTCoiZu0m7i3ZsIKPbCRluDE2FFaGnLuBDN
	VRbOmn9E5sbfV8wL7+EibqEfAUZ5eiwUdZlx/xWesAH/cX+iTR07
X-Google-Smtp-Source: AGHT+IFUaNRlWbTUQ7P+eX0nFhgyBAXy0yNJ3FH5SVdgi7W0aRoHe0SdL8k7dK+mueYpZy/SsNE2Qg==
X-Received: by 2002:a05:6a00:b87:b0:705:9b04:71b with SMTP id d2e1a72fcca58-70b43664bd9mr10725485b3a.31.1720731967479;
        Thu, 11 Jul 2024 14:06:07 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-77d60117b61sm4784747a12.22.2024.07.11.14.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 14:06:07 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 11 Jul 2024 11:06:05 -1000
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
	schatzberg.dan@gmail.com, mingo@redhat.com, peterz@infradead.org,
	changwoo@igalia.com, righi.andrea@gmail.com
Subject: Re: [PATCH 1/6] sched: Move struct balance_callback definition upward
Message-ID: <ZpBJPRf5lnXxccH6@slm.duckdns.org>
References: <20240711011434.1421572-1-tj@kernel.org>
 <20240711011434.1421572-2-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711011434.1421572-2-tj@kernel.org>

Hello,

On Wed, Jul 10, 2024 at 03:13:58PM -1000, Tejun Heo wrote:
> Move struct balance_callback definition upward so that it's visible to
> class-specific rq struct definitions. This will be used to embed a struct
> balance_callback in struct scx_rq.
> 
> No functional changes.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Acked-by: David Vernet <void@manifault.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>

Unless there are objections, as this is really trivial, I'll apply it
together with other patches. Please holler if there are any concerns.

Thanks.

-- 
tejun


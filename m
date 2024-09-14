Return-Path: <linux-kernel+bounces-329508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA4E97922A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 18:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27DEB1C216E3
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 16:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CA81D12F9;
	Sat, 14 Sep 2024 16:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iN18I8gl"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A821D12E2
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 16:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726332304; cv=none; b=H73yGZ7XR+5eITCC7jG1WRne+6OdWToJfbzIAVRK14WiQK/Ba5InKIoEuKHzhnJ0TcGOfZNBk5EcsISPZbMhqq5wcK9e73ma8ZX3UNav+PPXBNu4VtE3lMZciFYf2+NN1HdKWTT9hlHJh7Aw+0ulWmquURRohWctKJay7ykLH0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726332304; c=relaxed/simple;
	bh=VMBG2Dh3Zw7faqlpcqUYMWLfsHTm5HJFrtJVUFbwLYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bI9HnkBzxU4v0L3Yc/r6HU1aRCocB7S2TLwHxo2VtT74F4NP+3YP3Wo8yiNHm/nrw0Y4bNxsL44yhHITOFkB/IVd9nHfZx1j0ryXcZ4LBB2Dq2r59SCOgfTgKCYS8UCcWuivYe6rl+CvII8U2wLLM/2UfBPc+itH/E4dTfuGkJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iN18I8gl; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7d4f8a1626cso1502110a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 09:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726332302; x=1726937102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jho1JF+P59lkbzGdVgYwLqxMLIAumaTqEKGdD7HjJX0=;
        b=iN18I8glGCCwT+FSVt3dFsSa6m6sE6Q+8jQxBQ3xcQ78bj7a/lNpWshsTYMnmylXIA
         pPc5RunEKYqNUEKOFymm01dIEmxEZR1xQin/fRBaWOp1zZbUDJ39O7+BH9TeuvaPs7YN
         U+5Z+TB5JLVjPV1xVhtQ5vyJD3dtj8vn7mxDcK4Qd5C+8E2dtRDXEgxt5MpUbypmo9rB
         hDmNB440+/6vc7DOcy6LP/I4WYgves705pPNmIbt93b0RomJplJfXN/xnkjVYO2MqyUD
         HsoJ//u/0PN4S/JR+eXUKYWC8slkk0ynO1yHmp6tmI4ePF6haGeh3O58UbxgWKfn3yOh
         hioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726332302; x=1726937102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jho1JF+P59lkbzGdVgYwLqxMLIAumaTqEKGdD7HjJX0=;
        b=uP9vTrYE70Ct8Od+9R6rmnwEmN9Wxy35LVLK8rXnQiyPAXpUjhEUbwOuS3f46MkTo7
         5UnmtmjSlt7SxwpS0vVbqj8W3gKHmjdMMOiFWlyiWg+WgLerPV8t53Y+FbwvHlLibNup
         oLEvzXpvyz38aJE93jRUeZyosbwxw1e48bOBwmUMhWfOMGM/cExRDeS7RBWn8hFvKGhI
         4Zns/zA0Ikx6lS7pjMyb8rb68paw98iGFYLWfOpxFOAfSQW6g2Du7qRq0q9d2ww4z6sM
         iV2W/OXCG0+x+v8N6ALS13B/jeb32jaPQe7sf50E2AZAnX16gitMtrTmBblOSYwz16/L
         F9Xg==
X-Forwarded-Encrypted: i=1; AJvYcCVcH0q7ykmzHpHAug+J+O8b3EFgeX39MbB3HTy1zwCQoID8fpSNRyU5D1EVCHPFo3xgT+Wppamjih4PdBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdNBtizqnAFXR0tOB8WkLxluL8AfCngT0PXnyCoDr0Qkdxm67U
	Q219fuMwLChKEwVcryStl7+GHNj7x/S05Eyi6E1iG8MOzjiQMS6zKjVGmYrRBPk=
X-Google-Smtp-Source: AGHT+IGlu9u+g3BPmkH/baJXqXWvTrZtLsscYZ70k87KumegUKrIqkB8liTQ2W23TEeaRKBwr286pA==
X-Received: by 2002:a17:90b:1c92:b0:2d3:bc5f:715f with SMTP id 98e67ed59e1d1-2dbb9df9afbmr8375713a91.10.1726332301803;
        Sat, 14 Sep 2024 09:45:01 -0700 (PDT)
Received: from embed-PC.myguest.virtualbox.org ([106.222.229.152])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbcfdc0ac3sm1737304a91.53.2024.09.14.09.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 09:45:01 -0700 (PDT)
Date: Sat, 14 Sep 2024 22:14:56 +0530
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: skhan@linuxfoundation.org, rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: octeon: Use new initialization api for
 tasklet
Message-ID: <ZuW9iInzizGypLRt@embed-PC.myguest.virtualbox.org>
References: <20240913191734.805815-1-abhishektamboli9@gmail.com>
 <2024091424-glisten-unmanned-bb8f@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024091424-glisten-unmanned-bb8f@gregkh>

Hi Greg,

On Sat, Sep 14, 2024 at 10:20:02AM +0200, Greg KH wrote:
> On Sat, Sep 14, 2024 at 12:47:34AM +0530, Abhishek Tamboli wrote:
> > Use the new api DECLARE_TASKLET instead of DECLARE_TASKLET_OLD
> > introduced in commit 12cc923f1ccc ("tasklet: Introduce new
> > initialization API").
> 
> This says what you are doing, but not why you are doing this.
> 
> Why is this needed?  What bug does this fix?  The code is the exact same
> afterward so why should this be accepted?
> 
 While this patch doesn't fix any functional bug, it ensures that the 
 code is kept up to date with the new Initialization API for tasklets.

 Regards,
 Abhishek


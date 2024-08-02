Return-Path: <linux-kernel+bounces-273147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6586F9464F1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 23:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 972D01C2140F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D4B6BFD2;
	Fri,  2 Aug 2024 21:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpF+1Q0P"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1035336B
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 21:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722633621; cv=none; b=XU1tPlPdoH6zB7Oi5xgUGXNEDamKiF87ESEuwo+gWMy8cDn4TBeDKYgJTj3Bn31RRz+7n2xXA6tKtHsGynI3fJ7PSOv76xU6+rOa+9cX4GrTFABE3ONmXWMHJyEJrlq5TXxrOrFwcZDYoGBCdrIM9D9CO9Vu2OrPYjGXpy8LqJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722633621; c=relaxed/simple;
	bh=JAxI0tIveaRUM1Sa7raCLp5SSFua0iswNm/knAO6atM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WbabA4XJmR1DNRNbCCbeFlDzGDHDJTa8j1J26fc+cdGWbDw6L0/Ph1htWROPpuKavyeXf5beHekH8trn2ewhQuV/hOffAgb9EDQyiNGqKIOkuJUSjervQ0yHR4jNYDKkJCcEgNthSKgJ0Tacuu//S64vgXlVGgNxjxoap8vWz5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RpF+1Q0P; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fd69e44596so27184375ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 14:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722633620; x=1723238420; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OMo56xegO/7DGlX/Lh2d4b7qel6IFmBCrjZ1JJGtWxQ=;
        b=RpF+1Q0PG3NHXatHRlJsws0ff4Hqycoj4m7e6o8QVeznjJSFhlkwPWcUgGq2dDVQxe
         EccXh4J24/af9B0nt9KCG2zKbNR3A4Uzm3krOC6rjCD43cE/l+KaGjRiW3zWypV+OuZ8
         7xG93FP1TTSE7lo51RV4zIxIyaHn7c18+th1W8IGBIxawKrFigy4qnrsvTxP49ZLp1wg
         BjrPyR581+rdQNzOWFGQcRdxGXXmX29s+aQHMCjO+sKlWpKh02nyPSSlAe8YNECH2AAX
         +Db7Z04aLWDm4mvXobjE8IGXqcX+RxFRhCna0WJ8GXioNLaMkcj+dIGoHil8fe5a9/qD
         7nqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722633620; x=1723238420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OMo56xegO/7DGlX/Lh2d4b7qel6IFmBCrjZ1JJGtWxQ=;
        b=i7pmE792SPMSGpYu3A135lD7VjJdz37hl/WT9Bd7CbLY6NjKe5ihK+XrqfFbn9A6+y
         FP1aoyw/p/gb0hpuvyarNdHIy1tfyTlvBU+hwfOFfVYoD06v9YVEeJyDmm/Ijck04j0j
         GsX5F8TKbXWaubiSEuUgprk0yg3MYlCMpj4r8n5EZ7Hfip7d+lc63CqCaGUFCdAOvTzO
         GJwP2Jz6XEj6Jym4FQHAT8jru8Vwz67wMjsSwZGyg+bstpUuNyWjv52xF9Pceg6su16R
         +DxdeTg4rzuPnHIeCkAbp8Na94ex5rRhOVdq7fmva2NO4LONoejSpj4wJvHc3aNC9FmP
         jlPA==
X-Forwarded-Encrypted: i=1; AJvYcCWrURVWW8a2gioghlnI1/a4yut4Ys1VfqD3SxcZlE/Fu1idReUHHcRGa1hFegw0jRk92rM5T3zmyAwWbCRZ7IsOVBdgatMARu3ExGtZ
X-Gm-Message-State: AOJu0Yw/EhMzRNjP6ozwb+8CWMfC/vGPDgA5mQEgVNyXJxCH09jdJJcY
	2Fb1dBmkX/2l2tNajh9ykXT57/F1eaQzjiJC52hDzF3xajhg8cTN
X-Google-Smtp-Source: AGHT+IGy6B8YLI61aC4gyS6tT2tDoxUyk+gqb1SZoTfPhT8shUYbuwwOxy3Rp+9FKgpsVfzpX10XzA==
X-Received: by 2002:a17:902:f641:b0:1fb:7654:4a40 with SMTP id d9443c01a7336-1ff57bc159bmr80721685ad.14.1722633619793;
        Fri, 02 Aug 2024 14:20:19 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff592928ffsm21787095ad.243.2024.08.02.14.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 14:20:19 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 2 Aug 2024 11:20:18 -1000
From: Tejun Heo <tj@kernel.org>
To: Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: void@manifault.com, linux-kernel@vger.kernel.org
Subject: Re: [sched_ext/for-6.11]: Issue with BPF Scheduler during CPU Hotplug
Message-ID: <Zq1NksrG9blyN-KR@slm.duckdns.org>
References: <8cd0ec0c4c7c1bc0119e61fbef0bee9d5e24022d.camel@linux.ibm.com>
 <Zo3PgETt43iFersn@slm.duckdns.org>
 <dde4b09001da2641f9679b9409727e2147c5e9a6.camel@linux.ibm.com>
 <daf2370f5456cbf1660bbdc13621559fb3f2f6cc.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daf2370f5456cbf1660bbdc13621559fb3f2f6cc.camel@linux.ibm.com>

Hello, Aboorva.

On Fri, Jul 12, 2024 at 03:34:59PM +0530, Aboorva Devarajan wrote:
> Hi Tejun,
> 
> On Thu, 2024-07-11 at 17:30 +0530, Aboorva Devarajan wrote:
> 
> > > It could also be specific to ppc64 (e.g. there's something dependingon fork
> > > during CPU hotplug), or at least doesn't happen on x86. I'll probe it a bit
> > > more.
> > 
> > Sure, so far I haven't been able to reproduce the issue on x86, also I'm running
> > some tests for a longer duration to see if it can be recreated on x86 as well
> > inorder to rule out the possiblity of it being a ppc64 specific issue, it could
> > be that the issue occurs much rarer on x86 when compared to ppc64.
> > 
> 
> I have been able to recreate a similar issue on x86 as well, so this
> rules out the possibility of it being ppc64 specific.

Can you please applying the following patchset and see whether the problem
persists?

 http://lkml.kernel.org/r/20240802211850.1211737-1-tj@kernel.org

Thanks.

-- 
tejun


Return-Path: <linux-kernel+bounces-395476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFB69BBE5F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 21:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F70B1C213DF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 20:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93961D363F;
	Mon,  4 Nov 2024 20:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="DWzlXt17"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FD71D318C
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 20:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730750447; cv=none; b=ErT1PlYdPVKfAWij+D/W27pwHkBbUhE/j2vslqcsNPfhIaWkYsoGwMsCVP1dTnWeQh2SgQTXMZ9DQ3YN3/rD52CCq3Bk/7K4c/qk3o555SvJLKwm1ggR+VG0s4cqSCGaMiLFGSCLaXN3tDjoalyKvB0eJCw+kY7eWo+VoY+pmps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730750447; c=relaxed/simple;
	bh=Cpg3B8hodUewEtvhoEucmrqhdHeU0oL39fsPPIGp+Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oi/lsiEqhZNCxIEhbQoDU2FXqRb9AYzrPAsAnSK+0EjhaAXFx5acHA0X3X0snyTzHubnGCdl1Ep4Ua29w2t08diQDnvhlBCYKUfSUMjBJH0AUBUhZXNuSy1bHTZ6oJObdUeCsU+LLSsTqUb1uAETz7r10z0zaBPwzYVSh1BBkRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=DWzlXt17; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7ea8c4ce232so3852370a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 12:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730750445; x=1731355245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TMEQlN1IEjZdYabCRX4ehOZgAy1jqQ6lORiEMfo+VFs=;
        b=DWzlXt17+hgKWSup7gWCVi1mePSazgM7Qj7gFaa7PvzOcxiCJBl0ER2E8c+qhHkdIf
         RTl4jmw/ibA8pgC7CuSPhJknNXLDame0amEGKwVCmt3biy6KL4XZhgDrL8fI0Uj+/9fU
         j0b3XwiT0CEFfZ9IOzzZ2m21MkQnSQs91tQbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730750445; x=1731355245;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TMEQlN1IEjZdYabCRX4ehOZgAy1jqQ6lORiEMfo+VFs=;
        b=olPUWSdHbiGHSz/zIEhAPqDBTb+YJKrlwPtzKw/HB/pzkU1Zc5ntNZqHXbIUOTUJPH
         eV3P9qwg8qNLr0tBx18AFR+xI7WN1FILZUhj2WphYmhMehdqa7eToEAzhyibAMguGG/Q
         0Uq4DVxuMc//UVmwfjtQ+NS3FJ+3Af9OMSm3oGWXFD7DT1iGyGa6M2HqkyJJJy6sOQ5W
         yHxKWm9tKAahE39kEhYzK3SqGVdHhUW93cAT4ZQk9uv4B/t+spr6pX7jn7zWM8LQYgX5
         wsKhse9k76SPgYVkTAyWKRy193LTFQueJbx0l/8ZBcIt5DTSs8VCzPWiIZu469oIC7H+
         /xyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzONGKqJt7mFcO0NqsLHq9DlRNlFAhZxy4dnY+ml1r4Y5+nN+RcGPIAVHqdpDms4i4navQKKeAYVmhOGA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxg1elw4suJqflnt0HuHFe0s7jgpj2AmiAAeZGXp+BugCQ1S8b
	60Vfm0aBxxAhDGJsISGDi5W0O8yb+GzHLk3o5xCTBZ/5GSSFmsuKtCPAHMWEaW4=
X-Google-Smtp-Source: AGHT+IEOGcBNPTKJTMRsT64uhkirLvN3Mx9+dG4Ws1sfY/DuzgIEkl83SOeG4mXfBHlfrlmT3ps81w==
X-Received: by 2002:a17:90b:3886:b0:2e2:ebbb:760c with SMTP id 98e67ed59e1d1-2e94c2bd744mr19442434a91.11.1730750444760;
        Mon, 04 Nov 2024 12:00:44 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa262fasm10496720a91.21.2024.11.04.12.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 12:00:44 -0800 (PST)
Date: Mon, 4 Nov 2024 12:00:40 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, netdev@vger.kernel.org,
	hdanton@sina.com, pabeni@redhat.com, namangulati@google.com,
	edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, peter@typeblog.net,
	m2shafiei@uwaterloo.ca, bjorn@rivosinc.com, hch@infradead.org,
	willy@infradead.org, willemdebruijn.kernel@gmail.com,
	skhawaja@google.com, kuba@kernel.org,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux BPF <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v5 7/7] docs: networking: Describe irq suspension
Message-ID: <Zykn6Hr0lpqyPBPR@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>, netdev@vger.kernel.org,
	hdanton@sina.com, pabeni@redhat.com, namangulati@google.com,
	edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, peter@typeblog.net,
	m2shafiei@uwaterloo.ca, bjorn@rivosinc.com, hch@infradead.org,
	willy@infradead.org, willemdebruijn.kernel@gmail.com,
	skhawaja@google.com, kuba@kernel.org,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux BPF <bpf@vger.kernel.org>
References: <20241103052421.518856-1-jdamato@fastly.com>
 <20241103052421.518856-8-jdamato@fastly.com>
 <ZyinhIlMIrK58ABF@archie.me>
 <ZykRdK6WgfR_4p5X@LQ3V64L9R2>
 <87v7x296wq.fsf@trenco.lwn.net>
 <ZykXnG8M7qXsQcYq@LQ3V64L9R2>
 <87msie955t.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87msie955t.fsf@trenco.lwn.net>

On Mon, Nov 04, 2024 at 12:21:02PM -0700, Jonathan Corbet wrote:
> Joe Damato <jdamato@fastly.com> writes:
> 
> > Thanks for the feedback. I had been preparing a v6 based on Bagas'
> > comments below where you snipped about in the documentation, etc.
> >
> > Should I continue to prepare a v6? It would only contain
> > documentation changes in this patch; I can't really tell if a v6 is
> > necessary or not.
> 
> Look at the generated docs and be sure that results are what you expect;
> the enumerated-list change may be necessary.

Right, of course. I just did that and taking Bagas' suggestion does
make the enumerated list look better, so I'll send a v6 with that
change shortly.

Thanks for the guidance.


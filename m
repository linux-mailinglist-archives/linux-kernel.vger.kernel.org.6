Return-Path: <linux-kernel+bounces-532353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A18A44BF1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 318B17A4091
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B9319D071;
	Tue, 25 Feb 2025 20:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WbHutTCA"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB6419992C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 20:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740513912; cv=none; b=GRmjJ5ERZbisxq75gMsBaWpKsPqC0oY3Fue4zPadJvK/+sdeS5eIeDdrrhcUq1BMR/pBy90ei84AYovFhTyyp5cLLDCBD8+1Tope/xzN8Bw3rrfcE2JEKMF+v4x4zIeWnmD2TLvajrKw2WpSHRhYGwMmVVfaR5KJGdv8/KoO3d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740513912; c=relaxed/simple;
	bh=ZbFhjhJzzPdU7qg4OL6BpZWoloFSSDxEJNo3uKjV7Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IVTK6bwbawY3eL3GMzmJe//bz7OaIJqZMdw30rUWK55RfJ+EAeFZZLqtHsInQRsQfnwiTWQshsbxUHQfUDWkQ/OVQnQUstza/SEd7JZr8I8WvkaHbAzx0c2mgubGAXWd8GAOw2nympL5xWLSEMYLPjiSAEKiZT+ureT+LAwNb8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WbHutTCA; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-220d39a5627so93681495ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 12:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740513910; x=1741118710; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M7rRRMf5SsNxWlQh/JxR+Ow4SZo3/cWOaF5W5bjLrDg=;
        b=WbHutTCAXvbtYNGoD8NAazTBClp4JfYyVb0/Ll8MUyFINrHOnJKkhdF6t/4ENPYZcg
         PjAkDk21KSB8AIdLlCVYVo6h6fMVF+pLQvRIFHdbQBhm23suhRHnqtOFcYKwt9iffS//
         en0i5IlEP3C8GifQdzIr22F/mFbT0oWYwbJwempS2DfnkIYaSnuGp/b0dGcL9HwuyKTY
         sVCcF/0+JPgZgkS+HjHrrJFKR8kCtBhNjft4njmydXj2obMkrQeXVg/5M4a5lCCPGHWe
         RazeulqtEvqjqdVhGjg6EtL7VkMPdJ057B1LD71+Qt5Y0lnfJg+HcniZvJsuCZ7ylWvG
         Ts4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740513910; x=1741118710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7rRRMf5SsNxWlQh/JxR+Ow4SZo3/cWOaF5W5bjLrDg=;
        b=M2xDmVvM3BAdolUjWUYALRR44H+ccHcHpCh8tmqMk1Aol3tVD4Q2qGedS89fQfxybO
         ujAKeZYTSSFKIzQ2eZPG8FmBsNzMSGLwKzjx7nDG6hw6EuDbTrycgXzjnotfdbsufWt2
         c4ho2JNOcpAYEA+5iGbVVftZZxYAePl3VHY1Sj2LTYMaDUOmb/RpcnfF7axrjwp5/p7n
         0xEr1jnas/CGRMFKMD7ETJ1hc4EATS2CIXJ2VtvWaUNuR0qDsEHO59P/6KQR1WKMi4IW
         Tejl6VTpdS9WCU2V2h+t7QJKcmUKE/oTQtmudmVp9d3R33ZUn9XUulTq3hUsVIVjYDpg
         4kEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWdYbwBzrlwF8sPDesUazO9B8sRkE6gcaTAOqIzGF/XcD+Hc27eVRpSoYNatBD/AKu+vkhox7hpEdBcSk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo40XsOSHKOnWtz0sXKhE0vkwUSYyteMiYqiHWtHZQjMXviMjm
	5HUS0/TFdGYmW0tyI+89YXRSRlOjMbMIpL4cb7Z14hrGwu0qlZRz9Hfe0JCv
X-Gm-Gg: ASbGncvjq6lsPElvaqG4dw1q7CrVbBLBiusqJ5KVgU/2+uvW1I93tYJc/ZTE2s3fVPM
	ZTDdyOSAesc/nq/CYKQ4ZnDv2hbVEtywK5HJg1fmjWP+PtlsPpM8kR8N0H9PJ451BBZt1SmmkK5
	3ba7AUJIoSX5Ixszdg0lBCCQJQ+DC5ysLJDmQJl9MQzmw+mMEJjFzvHac1pC3p3466s5nxWnpfX
	qFaDo52uNXmWUIOZXReUFusw51wxv9KwFbIQo9zGFbUjdXZpmQ9MQ1SX0ws1PAEpB6901gGRfJx
	mo5Q6oONuj4KdxcFIq0MdzU6ERnF/LV41HHsh2Qai/cEaOfoo8N5RcdxPA==
X-Google-Smtp-Source: AGHT+IEmzpdRfroAIEPIL7+pwQe4f2ES9B0C6EZn6C+xpvOPqGSTIOstqonfdnt5BpA5MEdSGccDEw==
X-Received: by 2002:a05:6a00:84a:b0:725:e4b9:a600 with SMTP id d2e1a72fcca58-73426d78ecemr30572954b3a.16.1740513909595;
        Tue, 25 Feb 2025 12:05:09 -0800 (PST)
Received: from google.com ([2a00:79e0:2e52:7:2633:28b9:cd56:888c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a81ecaasm1920426b3a.153.2025.02.25.12.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 12:05:08 -0800 (PST)
Date: Tue, 25 Feb 2025 12:05:04 -0800
From: Kevin Krakauer <krakauer@google.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, shuah@kernel.org
Subject: Re: [PATCH] selftests/net: deflake GRO tests and fix return value
 and output
Message-ID: <Z74icGa4rlnNafoW@google.com>
References: <20250220170409.42cce424@kernel.org>
 <20250223151949.1886080-1-krakauer@google.com>
 <20250224124830.7c38608a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224124830.7c38608a@kernel.org>

On Mon, Feb 24, 2025 at 12:48:30PM -0800, Jakub Kicinski wrote:
> With msec-long deferrals we'll flush due to jiffies change. At least
> that explains a bit. Could you maybe try lower timeouts than 1msec?
> Previously we'd just keep partially-completed packets in GRO for up 
> to 1msec, now we'll delay all packet processing for 1msec, that's a lot.

Results again with each test run 1000 times:

gro_flush_timeout=50us  napi_defer_hard_irqs=1 --> failed to GRO 0 times
gro_flush_timeout=100us napi_defer_hard_irqs=1 --> failed to GRO 0 times

gro_flush_timeout=50us  napi_defer_hard_irqs=0 --> failed to GRO 36 times
gro_flush_timeout=100us napi_defer_hard_irqs=0 --> failed to GRO 46 times

100us with 1 defer seems to work fine and is well below the duration of
a jiffy. So we'll usually be testing the "default" GRO path and only
occasionally the jiffy-update path. I'll make these the numbers in the
revised patch unless someone thinks otherwise.


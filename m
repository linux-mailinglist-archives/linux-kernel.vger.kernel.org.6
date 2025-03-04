Return-Path: <linux-kernel+bounces-543252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 937E3A4D35F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFB3A16C742
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477001F4622;
	Tue,  4 Mar 2025 06:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="16t7dWnd"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1E91F416B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 06:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741068258; cv=none; b=Zpj5W1FZyNKXeAW5WoSZNkUsOpFSe2vPhUx75S8terjL69jwVzxnXyMSTsdAcADHhhD+Yo4RR33UZ24tUom7efnS9ij0c/P5MsVfns0podoPdYuDzIbQcQpRdpMid0MTlRi4SueGVzFNhTOrIz34jU+3WOx/NXC6JTsgzq67128=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741068258; c=relaxed/simple;
	bh=mhRvmZqgWdvLJYlas6Dyo9C2SYeBoyRC3wqmkHKeWgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vc9kUYkQHGOVtnbQ4ou1q2AfWmJ0sbT1lnyEZZJh2rI//AoSLJG34o5baK1T+vEkQM8yGifjJAezoLLuNGb91IomM/pa5kjU+app4MIYNv7Rf7jk6YWxVL41xcWTSrGZqgsQh9xhh/oUin6+oUEc+cyal5oHagu661MFxxGoWfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=16t7dWnd; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2237a32c03aso79115ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 22:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741068256; x=1741673056; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sAYlIekbsytWpG//ym3d1mjAZ0z0kh8QARPEq9BqGjs=;
        b=16t7dWndXix8Ut8iNXuQL+ZFrIZ146QfoGUNMkX2ENR77zH8g/8JFOumv07SKLBngc
         /lyI63nAgPqF6gm9gDl3WtbwR18kaZM1se5P5HLOFtrBAtcD521FCP9yavHW6aibSPhl
         eMy/FZmbWya3SapSgsj9OzlXOrg4UJQiRT+7B+1oWNT7osStqnu1d9eBEGiFKeqhD9MQ
         OuyaRHlaDGJPpEBTD5l1PIuGkQAzgc2GXgVp+px9hHbiQZoUu2Z2b3KJutfWHv6DpO0g
         yZDyBbVGsxw7W9GGyR2f1onF6W+Mr9DDeNkI/0+Z3Xi4umDG015wG/2D1msG7y9tCPdM
         aZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741068256; x=1741673056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAYlIekbsytWpG//ym3d1mjAZ0z0kh8QARPEq9BqGjs=;
        b=Jic7t/MDNwST4s7YRQEVosx9YJhpSTEE5uoCAHspP9Xwfidkd2LJRmV35N77D3FBPe
         QZok77JUzJzUa8KlECjIBJANat0npzG9EuAuACkRHWlj8Tc57GYyGxqutxtNAJAnWSA0
         keHP96/ATB/Z4zZQc1F1vePRHs77juekoj8606l701fHU89PXVUBTTzxLNTLMHmZSmhw
         qyHIpRBxLmCNkKJbUz50TxO+GHYbFnpDjXZ3SGIAdlPCGKVO9pZAvbyiaWPX3YkcVYoE
         6qw3v4307nPstEsh8+gyhI18UwfPJm1pveOrnrq2F0TacWxRHn38IxtAeNtgfEewO8hZ
         lcIw==
X-Forwarded-Encrypted: i=1; AJvYcCWXrzfQU/OZC/b775Das0ph5SFCUrp49ML5IcEtYaAZ/6usVBPqcLJnYW7gAhG6if5duNKVI8dFD53356Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzniFnIL55+QrhNwKCB2zrzgjbNUHiTC5ZbZJChnIJBhMr6TT6Q
	MokP6dBNv8Tu636jlad6TS55736q4VbkL8A618RKNVovmkg9Xt84qB6qp/3PrnpeahGlaYVrXSQ
	qfg==
X-Gm-Gg: ASbGnctvyg7vObqgawviGvzsbNsmBrCoGPGooCmjVxeWKeg8ddmsRwKnNRa3Q6vsP0b
	lPhmte3a2c6bnGqKujlMxPtV4Vd+AzaYu8ttaFjIUNDMvdLBs0BPxnBaIUwN+kadmiYbhhSii0j
	65XsWo3pwL1WoEeV+ZjsABb0TE83zj++hzIWKh35WNzpYeVtWRgYbyLZgSC1899bL+UlE+jfwm5
	UrVr+evBmsKC9c6ttCSPPDfV1fv1pg8v56TiBFI9AmRT0xROBE6JvxN+NlbCLuqjvYKKfkjWNKF
	dhu1E/ZZ9U7C2FTFmMXEXTHS+ABmzUt9eJkWkW7Zu5Hq4MVfyTbUSN1SVUfyio+hcITYE9Ivoq9
	aoT3DR1Q=
X-Google-Smtp-Source: AGHT+IHqKnibT1s5HFFAINhOUWrBIEJxBR8aCf+9habHUqIWadTtSdR+nmlVUa1RzzG2S+S6SNMC4A==
X-Received: by 2002:a17:903:2b10:b0:21d:dba1:dd72 with SMTP id d9443c01a7336-223db3fe05cmr1287665ad.15.1741068256111;
        Mon, 03 Mar 2025 22:04:16 -0800 (PST)
Received: from google.com (147.141.16.34.bc.googleusercontent.com. [34.16.141.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7363a0f88bfsm5510505b3a.24.2025.03.03.22.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 22:04:15 -0800 (PST)
Date: Tue, 4 Mar 2025 06:04:10 +0000
From: Peilin Ye <yepeilin@google.com>
To: patchwork-bot+netdevbpf@kernel.org
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bpf@ietf.org,
	ast@kernel.org, xukuohai@huaweicloud.com, eddyz87@gmail.com,
	void@manifault.com, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, corbet@lwn.net,
	paulmck@kernel.org, puranjay@kernel.org, iii@linux.ibm.com,
	hca@linux.ibm.com, gor@linux.ibm.com, catalin.marinas@arm.com,
	will@kernel.org, qmo@kernel.org, mykolal@fb.com, shuah@kernel.org,
	ihor.solodrai@linux.dev, longyingchi24s@ict.ac.cn,
	joshdon@google.com, brho@google.com, neelnatu@google.com,
	bsegall@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v6 0/6] Introduce load-acquire and store-release
 BPF instructions
Message-ID: <Z8aX2j2WYd4DlnCH@google.com>
References: <cover.1741049567.git.yepeilin@google.com>
 <174106503648.3866937.5658954004964289425.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174106503648.3866937.5658954004964289425.git-patchwork-notify@kernel.org>

On Tue, Mar 04, 2025 at 05:10:36AM +0000, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This series was applied to bpf/bpf-next.git (master)

Thanks again to everyone for reviewing this!

Cheers,
Peilin Ye



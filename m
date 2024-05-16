Return-Path: <linux-kernel+bounces-181350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F878C7AD3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD72D1F226BC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E7614B94D;
	Thu, 16 May 2024 17:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LcCNd6Ca"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8221414A4E5
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 17:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715879356; cv=none; b=RTbo394cq2KiSAPfXckVPD7SphUFcHa/ZeUilx0ZlS12fKj1vlr6EE1yQdchllvIM6jA1h1l2O3npZhSamNpt2tlZxg+4IvEKZHdgPtZ5a1cQEq3iaCIKbuvuexGKmpmCHQX6DCXHgV04+TDi7h8CrqJB/QDF2bYmc2osF/ysOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715879356; c=relaxed/simple;
	bh=I+QuxV+clGRyaVcax9ZlD4uKiSfTKhMUeuT16IR1HLc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FfYwtA+OJnQJqNidedvyJIhna+8mMVy+VogFvg8PV/iFD58xpubLtHB1kw4jVqrAT7DlsINp453GW4AiUghqnUvgqCehNQegDzNl+MNCcpUWciW3L37RqTK+81/tgQb9QwXqhZXewxJRNNdT7br/X9pHKiK4u0QvtvRsG+trFPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LcCNd6Ca; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715879354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I+QuxV+clGRyaVcax9ZlD4uKiSfTKhMUeuT16IR1HLc=;
	b=LcCNd6CabPk9/BBN5Jk/Bj58NnxMmtO9vNx/MQ7eK1RhDCBvU9N/6fsegwN2vxnnksDyLT
	/KtRDEH3DBlM4nimFYMmackLR13ESe5GDniZcQKdQQMAJoATgwGfy5oaym0P1WVhDtNhJg
	RaR1eHwlTiQqQZNEQvaWdZQZmGKAwkU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-ZA5DfLR-PpW0tlsXV5EkOA-1; Thu, 16 May 2024 13:09:13 -0400
X-MC-Unique: ZA5DfLR-PpW0tlsXV5EkOA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-78ed2a710efso1176282185a.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:09:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715879352; x=1716484152;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I+QuxV+clGRyaVcax9ZlD4uKiSfTKhMUeuT16IR1HLc=;
        b=PW6vXs6JtGCSbdgfuY4wVmMac6RxwsYKxORw0QhXZi/H4CN+jW+Xe2GkKvsA+pbRhP
         P7wY/tHfB8p2USc1R+5zO0Z2d8CNQdiqY4gV3osCYSzrkp5LjEhR8nPMVayBuFh0rbnN
         lhk/2rMw4r/oQVwb8a99q/nB1+4yH6bpvH0OpRhn6YD4f998WXaYy3DXFISrjI/u/+Jj
         yxM71ymYhyWXEiZDSMOv9Cv/wDhNJuH0qhfT6ckyd40AOhuvZVpstyyDCXW6f3V1R7Ny
         GbczzhIv746LukRfAaIwmcIxU1zAERNaprL/KYXwurF9sVLiIfOiMbCYItcTYvRJRudN
         B+GA==
X-Forwarded-Encrypted: i=1; AJvYcCUESWJB/hDQ/hgMSHG35wfI9Zc+jPoPozPm/NtooIQgV8QV6loHCdbg1oTVtbMDAnjJadAG52XtztSXNo/ctUyE/0VDDwzpuoFM+may
X-Gm-Message-State: AOJu0Yw69VAmfqf90oUAGYKTFcdv7j869BoWowr466GOBJCgznR26bbM
	ziiQCNxo5AwPY6yyJDJ7TnfRXhwnPbJTWPmlHJ3BmurBNFeRcm0mPuKvLv+v85mPVWrZswQv5R4
	4H2X3yUV+kLdmmG5flfnLJO9D/8WIPCpWL5a3Vp9D4XqBBUAH2hOFW2I5E3m9KWzUtvnBgQ==
X-Received: by 2002:a05:6214:5885:b0:6a0:7d91:8752 with SMTP id 6a1803df08f44-6a16825d75bmr223216996d6.58.1715879352093;
        Thu, 16 May 2024 10:09:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEX0nPcN4BilITb6zIiGJi7ggyqJTFHPWgRq6sSz9JUFEtcLXMEaBNnPAb8fRGJNAI5sKxwUg==
X-Received: by 2002:a05:6214:5885:b0:6a0:7d91:8752 with SMTP id 6a1803df08f44-6a16825d75bmr223216646d6.58.1715879351745;
        Thu, 16 May 2024 10:09:11 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a32f4ae41asm52624336d6.71.2024.05.16.10.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 10:09:11 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, "Paul E . McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Joel Fernandes
 <joel@joelfernandes.org>, Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
 Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 5/6] rcu: Remove full memory barrier on RCU stall printout
In-Reply-To: <20240515125332.9306-6-frederic@kernel.org>
References: <20240515125332.9306-1-frederic@kernel.org>
 <20240515125332.9306-6-frederic@kernel.org>
Date: Thu, 16 May 2024 19:09:08 +0200
Message-ID: <xhsmh7cftheff.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 15/05/24 14:53, Frederic Weisbecker wrote:
> RCU stall printout fetches the EQS state of a CPU with a preceding full
> memory barrier. However there is nothing to order this read against at
> this debugging stage. It is inherently racy when performed remotely.
>
> Do a plain read instead.
>
> This was the last user of rcu_dynticks_snap().
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>



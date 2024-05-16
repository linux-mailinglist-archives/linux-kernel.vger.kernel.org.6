Return-Path: <linux-kernel+bounces-181364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 919518C7B0D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA226B22604
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597A9156872;
	Thu, 16 May 2024 17:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Bz5QkxYL"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B73B14D457
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 17:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715880151; cv=none; b=KSzuGuc+e8vSO0ngb6wDQ7JwPonB7V0vbf7S7NtOL8iuytY0TUXUREVvWV/feactvRpUXc0XhuYNB00GkVpGYbPmASqKM6Anf3nncfX1IYhV+r77uAstu88ukl6ZL7ev7mVJlbBFNipovY5oxlFF4tdGW6Eys5e7mw1rICAseUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715880151; c=relaxed/simple;
	bh=HAUKL+JYIytkSwCm2DOlRIspWB4tp4heky9US31dOOQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ROuK0KMjLljJCEn3GJo+ySJkF/lmmHh9HxdNPNEdBnfkht22UtEG1HxIOJY7sp1BdAH+HlxVLLtBlNC/LtcGUSODph62pv2fDYaqeHJ8qx9p/TlA2t9TaGp34bywOTQng4wbtZ6tWPuCZE4dRL7P66MZ+9t9R/lAL/20YT9ksyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Bz5QkxYL; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-572d2461001so3898691a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1715880149; x=1716484949; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HAUKL+JYIytkSwCm2DOlRIspWB4tp4heky9US31dOOQ=;
        b=Bz5QkxYL53tx33bPsa3sO3lEJ15SbCQ5Rb4zORV1aSsSf/xaIxPZgv/1L8K9oGb4eQ
         q0zT1P07Raw9XSyjYIyknK7qc2iy0wG0xan8310a+kzk6MH1qT9VC8GjAIpimCR3z8dm
         QJrr9nfXjNYYiq3pS+27bAiP0ObzRcpBkn3w4ustekgh/03gElMMvEgHoUqZQD3aRlY5
         2HBHK7B46FafJUIS08cRxj3TV8H2X970OfCKAHRMUzSSHRG/q5JAqWDVl9K7twcQW7Nv
         BJDDpSFpoRESkXmfVWdqdodgG7fSPqC6Rz7NokAQ6lGUBDLsLUgmw7gfynG8kEMKE5ol
         skkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715880149; x=1716484949;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HAUKL+JYIytkSwCm2DOlRIspWB4tp4heky9US31dOOQ=;
        b=abxvjoqcpPe6i8I1cC+REKxvhgO2CCUKQnnAmz/oSpplLI6eOhD0zveJjWOw39pZgb
         hq31KfAITeHPT0Qt9R8lta4you+AFUT8QPO6MdHkefLk2zJiYBwKX1XhGbRuPa7gXcyp
         0sUQbletNeqMSPUi42pqH2kYQbS4TBIsH+axkIROz6IHguFzl+c0ztvTO2Ocg6ERBJ8+
         emjfrTg7cWO0f8FKV/EvYgnPZfo04MyxO7mLDrNuq3TlDchZidV+PJx2RCQePFD5J7gn
         qsBXw4F8DkKQtXeBjBIhPkHxF0i4q6XgUqGvyi+x0h2QpBQuwdRxElBx1dq9BuSHJ0Yk
         aTgw==
X-Forwarded-Encrypted: i=1; AJvYcCUmUp8LEHL92VSfZtKE5URBtWnJkGfH0SxDzORWWU9lOprSV9om5joqBrWZnCMlzJGOG/tEozmEyQ/hkG4JRmjiV+F5uuzZfLy3rUMW
X-Gm-Message-State: AOJu0YyGSDhVkMai8IvZKxhZmRNwKmQQJ+6BlWydwNyFnli/cpH01ayQ
	Sagu1wEpo0+XqytNFYwwlZjiD8PIGTO5CG6LNcBTL7JSxblTTVpenSjSLV3wZWA=
X-Google-Smtp-Source: AGHT+IGyNgJXE1gh6QOSwbJEe8jOI9clq2LTrHyN9zq+JVSQiF4/sHiwyNAsZaIQmazyzrAjWKqNQg==
X-Received: by 2002:aa7:d1d3:0:b0:574:eb26:74a with SMTP id 4fb4d7f45d1cf-574eb260839mr5431923a12.21.1715880148676;
        Thu, 16 May 2024 10:22:28 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-574ea09b972sm3742247a12.47.2024.05.16.10.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 10:22:28 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Feng Zhou <zhoufeng.zf@bytedance.com>
Cc: edumazet@google.com,  ast@kernel.org,  daniel@iogearbox.net,
  andrii@kernel.org,  martin.lau@linux.dev,  eddyz87@gmail.com,
  song@kernel.org,  yonghong.song@linux.dev,  john.fastabend@gmail.com,
  kpsingh@kernel.org,  sdf@google.com,  haoluo@google.com,
  jolsa@kernel.org,  davem@davemloft.net,  dsahern@kernel.org,
  kuba@kernel.org,  pabeni@redhat.com,  laoar.shao@gmail.com,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
  bpf@vger.kernel.org,  yangzhenze@bytedance.com,
  wangdongdong.6@bytedance.com
Subject: Re: [PATCH bpf-next] bpf: tcp: Improve bpf write tcp opt performance
In-Reply-To: <87wmnty8yd.fsf@cloudflare.com> (Jakub Sitnicki's message of
	"Thu, 16 May 2024 19:15:22 +0200")
References: <20240515081901.91058-1-zhoufeng.zf@bytedance.com>
	<87seyjwgme.fsf@cloudflare.com>
	<1803b7c0-bc56-46d6-835f-f3802b8b7e00@bytedance.com>
	<87wmnty8yd.fsf@cloudflare.com>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Thu, 16 May 2024 19:22:27 +0200
Message-ID: <87seyhy8mk.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, May 16, 2024 at 07:15 PM +02, Jakub Sitnicki wrote:
> So in your workload bpf_skops_hdr_opt_len more times that you like.

Oops, I can't type any more at this hour. That should have said:

.. bpf_skops_hdr_opt_len *gets called* more times ...


Return-Path: <linux-kernel+bounces-354814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 527329942E6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 836B21C20F3D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF1C1E25EC;
	Tue,  8 Oct 2024 08:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UzTcEQGH"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA7313A878
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 08:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728376818; cv=none; b=prKMf0VZm9RpeLh9Glrdt7EcbI3tCDnXuPDYvo9vvqxHL4YNgrtKy/sr62WAi9/l3KCmz17k4fL2Vp9pZ/Qzp8jiKbrpf93DsRLTb6jfrGdpj8/XjXEAinCzvN9irYsKZi/Uiv6Zx+kZu4yjWC3x6Vo6dZr2fOXBt2n4nDAUpJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728376818; c=relaxed/simple;
	bh=FzO0G0Ihvstak33UPEIf4QOP6EIQSNPAXjFfigDGriw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pfs1peQVLGhiTXPrIb4xdayzrhMOE42SkwGPLtJlot1kwyT8aAd+CAHqqM1RRKBmdulGK+16djb/b4gvpwZ4E26NbhvqT8CXPCAPglhJowv+MkKCtVFPW7iKEqCyj5EVzW5Up4hQM1VwaDDf/6UsSxK+LjyP9sCgO/ScItlkAvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UzTcEQGH; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37cd3419937so3224154f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 01:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728376815; x=1728981615; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GzYc/0q2hqE5im4fm8nspzo+WjyiW8AYNygdA9wNAkY=;
        b=UzTcEQGHso2u1rrS7QNk2VsAiL+RT3t43RzR36uoEBE9YHReneBEqNTwd7BB+daqnP
         X8KOuGBilNeWRM3StbdY0UsGVMUFApNd7TfvbraEUxqpAE3rc2keKJr4eQ5qe6VGhFQq
         +TkFe+2hahpC5QqG02iwX+yfiG0aJdWbQ675Al8J/RuWHuQeWXGfLAVDf/NQbZm/wgwa
         92A0vZqlFQ29wUabdBH45f36ru/qcmNhTHtibr6tv7EkVuZgslhuBZZ2CDnNhhM58H50
         P9N+cFeWi1HxfGatOObIMSExFYdVY7Dqxn5rB9qrKgqSZ3nwwgMv4LZHmFMiubilD95F
         YTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728376815; x=1728981615;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GzYc/0q2hqE5im4fm8nspzo+WjyiW8AYNygdA9wNAkY=;
        b=kKqkb4PdTbb1vLTIxdt7qsZ9saLVVMI/mFeZIb5dhOpy6xCF1BO5dkyp554WYdRQw3
         3qu4DcRMKD95MA9jfeflt4ohq/pOAFSV/QVnYcdlWfxf4bqq/WJPGYjFyVTEVJTXAO9A
         17LnEfyFmxWP+6fUyzD7z+SujerIZVGFsNXYKd+Kh5V2Wfapecoc3/BVNCgZgxHlrwQG
         HI0CGcK61IBg3G70lYDfnRHDAeBw9NC2gGxuV5QgGfzFzXdkLhv678wRXYMIDgNJa75X
         byPw3XEQDM4tEKZiuAgPeHEkr4AXT+qmvP0smWsrd67HbsjB6wGzjYec7ePQoK3qvyCT
         wAOw==
X-Gm-Message-State: AOJu0YxjwEqJabSDAUcGe/059fcdf79b7AIqwjDB0IIQprO1Z5q5bk2w
	xjm+pJvHzQ4324eTam1sJujm7sIezGA5dECsG8BgjxMVWsHac44FXYWtHbH9h+39gXO25wCr4pF
	6
X-Google-Smtp-Source: AGHT+IGk1HTWqD+EsgM8s7iUh86EKp1j2hMdK55RiGbbiCvBIGG/pW6cak86eougntqoT1nhvbyEjA==
X-Received: by 2002:adf:f252:0:b0:37c:d21a:3d61 with SMTP id ffacd0b85a97d-37d0eafa544mr7358455f8f.39.1728376814817;
        Tue, 08 Oct 2024 01:40:14 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7465:5d50:9d67:2279:9c84? ([2a10:bac0:b000:7465:5d50:9d67:2279:9c84])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86a20595sm118895465e9.14.2024.10.08.01.40.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 01:40:14 -0700 (PDT)
Message-ID: <c579b5a0-2cab-4a33-b246-1e978154462c@suse.com>
Date: Tue, 8 Oct 2024 11:40:13 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 07/34] x86/bugs: Remove md_clear_*_mitigation()
To: David Kaplan <david.kaplan@amd.com>, Thomas Gleixner
 <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
References: <20240912190857.235849-1-david.kaplan@amd.com>
 <20240912190857.235849-8-david.kaplan@amd.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20240912190857.235849-8-david.kaplan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12.09.24 г. 22:08 ч., David Kaplan wrote:
> The functionality in md_clear_update_mitigation() and
> md_clear_select_mitigation() is now integrated into the select/update
> functions for the MDS, TAA, MMIO, and RFDS vulnerabilities.
> 
> Signed-off-by: David Kaplan <david.kaplan@amd.com>


I think the previous 4 patches are better replaced with the series that 
Daniel Sneddon has sent: 
20240924223140.1054918-1-daniel.sneddon@linux.intel.com


Return-Path: <linux-kernel+bounces-204543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E16F8FF049
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D82028A123
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927BB19AA6D;
	Thu,  6 Jun 2024 15:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pl46O4/z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A991667E6
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 15:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717686093; cv=none; b=NiomfgcN2DzJuABWweVCCiAKHtC+0AVZr7x3yKauQi/PRKz8TLoaLd94W98ew6dYP5wc1IrQHfao2wb+3FdJ7QOQj35UDL6NF+W6+t7CEjO4h+w50eueJcUKc1BV6fbm1IXIi8SfulAMu0+pFjFFhZJEykq7I2acmIAxyPs7aLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717686093; c=relaxed/simple;
	bh=O9MAf9qzp98/4x7roDH1u7DUx23gngi6st1Jji4B+Kc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=EDOpHApRO4xhWvQo54+w9SG4GMe1Eh2uZQNiuFqOyC5tnKUhxBM01FAqGTqnCjKBNGLLVkAhrJoyOFtesl3exStdL+5JHH2E38bCLiemHBV2Frk3DS7Skj6zuogofKpcMZt1fHhyU4YSUA0l9k0n0mK3dACOryemsLZFjj3jJAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pl46O4/z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717686089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jBb5kFou/O0zRv4ZHMlU4A8XTDPpz2EYXqLmgDRH8kA=;
	b=Pl46O4/zJIuTY44uqePRJRcP9cCZ7RME1P002la9Li2UXEpd3zLy9nA/BEzPloBeUIdJoo
	X/xqoaDxOnwcXOOVW/AzNQh8SSWE4862KzO+CpN8hv68GxZdIMd7IWk/bW6pJLi89HZhgJ
	bbVs0JZlF431+gSl23oUG6juS+iMzWw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-3IwB1hPZPlSr8-nL6vPmwg-1; Thu, 06 Jun 2024 11:01:28 -0400
X-MC-Unique: 3IwB1hPZPlSr8-nL6vPmwg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6ae0dc954b2so15244196d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 08:01:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717686088; x=1718290888;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jBb5kFou/O0zRv4ZHMlU4A8XTDPpz2EYXqLmgDRH8kA=;
        b=hEIGeUzwERNGo5dtDy+qQf4jgpepREnyoVkmpqHeLWYGYrs28kShAgCaHHWv8rJXQc
         hNboaIblsQslDMmUFXMRQvizgZ1Nl//e+9LXYGXA/ktv5OGtaZRMQEuwQbSp3wMCXkmw
         Tm5JU2dwIcuIMI8T+fdklKiIAA7ljeDIWCZFPQK4KnUaFw9HuheQmYw8Vp0Gg4Na7y3f
         vBWSn74FyghEccDC8We4LO3Fqo2kiIwuhCwi1V0X3Q2x4WSNqy4+KAmAAmVsquzNZGL+
         E128XFrQ8DVKkLNpKIKAo4CLfUg/cq1vHfL2o9qZwPj3Rvl8llICCmV1LrjwZ2AgFufF
         7HbA==
X-Forwarded-Encrypted: i=1; AJvYcCXahZj7nQg6NzoQf4zF9pG7zOIKfDTyw/dTeoRWtKAC3KzZ7frMoFN/rdIr2az6hPd2oigUUkxS/0y6IMx4vPH9IFLr1ZWDV/HDPDvq
X-Gm-Message-State: AOJu0YwWhWH9ipprYyYzi4I1nsM2moaP6GxztXTrbHyO7aResoy2XeIb
	IzX3tJJY9ioa8GbhQ/PS2q8vjpHQkZQ3xyQaZKelJ45B8NP7zkwWeeoVrNdDnt3Pzjng0E9geOb
	U79ggjbmk9xy1O35Bqn8smQCWip7p/iNwdIpzn4OZHJIjHXMxnrQOlQJBCegFpw==
X-Received: by 2002:a05:6214:53c2:b0:6ae:ba6:2136 with SMTP id 6a1803df08f44-6b030a1f207mr73502836d6.36.1717686087741;
        Thu, 06 Jun 2024 08:01:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRH7pcxj0JO5WLqrNYreesLzonwR/5WaCQB8j+jgwbAi0VAjzg+AL1oMiWygVgdyGzu8lrEg==
X-Received: by 2002:a05:6214:53c2:b0:6ae:ba6:2136 with SMTP id 6a1803df08f44-6b030a1f207mr73502266d6.36.1717686087022;
        Thu, 06 Jun 2024 08:01:27 -0700 (PDT)
Received: from [192.168.1.19] (pool-68-160-135-240.bstnma.fios.verizon.net. [68.160.135.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b056fd8b14sm1958356d6.132.2024.06.06.08.01.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 08:01:26 -0700 (PDT)
Message-ID: <930d7361-64e9-a0fc-eb04-79d9bf9267fa@redhat.com>
Date: Thu, 6 Jun 2024 11:01:25 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: zhang warden <zhangwarden@gmail.com>
Cc: Miroslav Benes <mbenes@suse.cz>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Jiri Kosina <jikos@kernel.org>, Petr Mladek <pmladek@suse.com>,
 live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240520005826.17281-1-zhangwarden@gmail.com>
 <alpine.LSU.2.21.2405200845130.11413@pobox.suse.cz>
 <BBD2A553-6D44-4CD5-94DD-D8B2D5536F94@gmail.com>
 <alpine.LSU.2.21.2405210823590.4805@pobox.suse.cz>
 <Zloh/TbRFIX6UtA+@redhat.com>
 <4DE98E35-2D1F-4A4E-8689-35FD246606EF@gmail.com>
 <Zl8mqq6nFlZL+6sb@redhat.com>
 <92FCCE66-8CE5-47B4-A20C-31DC16EE3DE0@gmail.com>
From: Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH] livepatch: introduce klp_func called interface
In-Reply-To: <92FCCE66-8CE5-47B4-A20C-31DC16EE3DE0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Wardenjohn,

To follow up, Red Hat kpatch QE pointed me toward this test:

https://gitlab.com/redhat/centos-stream/tests/kernel/kernel-tests/-/tree/main/general/kpatch/kpatch-trace?ref_type=heads

which reports a few interesting things via systemd service and ftrace:

- Patched functions
- Traced functions
- Code that was modified, but didn't run
- Other code that ftrace saw, but is not listed in the sysfs directory

The code looks to be built on top of the same basic ftrace commands that
I sent the other day.  You may be able to reuse/copy/etc bits from the
scripts if they are handy.

--
Joe



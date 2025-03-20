Return-Path: <linux-kernel+bounces-569884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D650A6A8B9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEC3917C969
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC381E0E13;
	Thu, 20 Mar 2025 14:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FFDJZ+nv"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB1A1DF25C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 14:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742481335; cv=none; b=ox36T5jZBHPiHOFoJxyQeFTW8U7XcTudKPD/gn+Y6MGwE03ueO1iAI8Za27pRwrQ5BA1xp/4kQ56JyRTjSzIFB+Ut8Y2JBgA77cD/uU0KRmgk38cLg/o+nDjLyRyAaYqrzlP6L4yw5SkBHeipAZYp+8McNBkbLmm7sjlsNw2c5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742481335; c=relaxed/simple;
	bh=FXdXd8ofe7k/I84sa2dhLHTC71XslY4SZabD8qNI9bk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SCGRknJeSkK55SMbssmoJStYgBKbCMwmlgo+DzCyaUp+Mpv8nNebcPMwXajnkhm6S3VSmU0zRThL+8EjrvFU7P8zNautSYR2w7AwBpfI8583335K9RIf0eFBb2XTc6K6Ff4/1iCnDkYCln0FskrlEYtTfvW96Yq4u7RSWWYjxwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=FFDJZ+nv; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2240d930f13so1795895ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 07:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1742481333; x=1743086133; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1mHBiutsAQAgKcMOaaTiD3xX3wZl0DqvVEeSgxZ+gf8=;
        b=FFDJZ+nvoqI5FvKwuwQ3pBqFm5+/MTB12UTjtByzd10rrm5NUyorzcLHELPFP1pRMS
         QNK4k62rCEAgXf3j4rnbcx7FXPfCE98YYZ0rN/dR5t9aQr+lS/TnU0RtEO/QEaIlfK8Y
         mfYev3EkEsBLyvAK4EcNygjdfDHGgV1GTz9cKvYHoxdEOJbu7ACP0uWU1wPaVPn9304C
         DZs7hxZg41iHdjXIPJdBCt7WIFsLYprSTGGQYGCVrG3ZzX0Sfb5PM2Mt+bWeH51lef3r
         VTw5gFEeOLaY5I9oJ9QHsgwr9niqV2s2ad0Mc5VPKMEt/1bNxwATtkDZZoFQZiOMgc9B
         nz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742481333; x=1743086133;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1mHBiutsAQAgKcMOaaTiD3xX3wZl0DqvVEeSgxZ+gf8=;
        b=u9eKZh66wf7euxghoZavQsu+/Cb0BYWAKaTVzMXpJ6BPsX15Ngn04ICN6yhqbAtA61
         K0Zxxa9w+cH9Qo55u218hvup23qdsS2ITuFqH/65Ewwb8Tzvjl2MQfuUHHQSBTGwCR6+
         wzGMths7PGl4TRs2RE1f1O+oZfZt5vqR7kfDxqj+0Nr3YUs7KQtE208CvaViOKVUo/rG
         5qqnfMOH/vn7vQ6dBk0FXxqOvwyfcjkMCFh86Y96hAO3o5XO5vMYXqGNb0V6hPyk8Ixk
         pzXlrgcwSc2OPimah3j7g6h6h8K/MHOtN5++B6dWeYeCDXM8fNFyvcktdDuh2fVHIQHx
         BoHw==
X-Forwarded-Encrypted: i=1; AJvYcCWmXAeYOo8bXi2aJ2chznUA/w6lWkhYXzZDhqa1LvVJGbotywybQHGD126ySDWDlNvvGwUxKs/x5+bXoy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtmaXXo5bi7hev80KZd0y0ZuqRC6IAFl2BBIV2Rq89sjZAQiAN
	Ro5ZYL8R50klhPABlFCIlAKhqwOu+jljIbdFvr0rrvqx/X/BUXP7oZQg/sdJ934=
X-Gm-Gg: ASbGncuU5JoO+tuph4+UZg8nRyzkaQy74ICjZd7mCRrZgZhfQc87Bs8yVZ6Z0du5Spp
	0DwweU4KtAa5RLK6jB299vivVEJPDTR35fHQWCPpJXuxNKWD6vYtsU9tS8FxGKrzTg424yW0xKM
	sz6AGaI0ZITpgFMmf9Gsp/YPN6kB+BX6jYDMNATU9b6/0LMKaQBHnaRJSe28/Cxgk+1aCPmq8oH
	u19CXpHELEaGLgCOwpNO8Aopyjd7VlMTCdjkc9JQmMd1CYJ6Jzoj72gAePsYNrOktNDZ6L4e/ul
	IW9rsvY/GUeNp4v9HIqz7p5L6sWUGL/ZRg/Xi4kr2rB+/boC5NZV6bdUQrpF/077l5j8
X-Google-Smtp-Source: AGHT+IGoCBmzRieVhlD8qer3+dmwOSMphcFtgFRI8xQDs0Qp4x9AKN7FZaVPdnKLxrP6k/3IqLloPA==
X-Received: by 2002:a05:6a00:ac4:b0:730:9989:d2d4 with SMTP id d2e1a72fcca58-737700de7b3mr3131100b3a.3.1742481332468;
        Thu, 20 Mar 2025 07:35:32 -0700 (PDT)
Received: from [10.254.134.90] ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737115749b3sm13891158b3a.81.2025.03.20.07.35.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 07:35:31 -0700 (PDT)
Message-ID: <4f7633d4-a1aa-4528-a463-552163e7a47b@bytedance.com>
Date: Thu, 20 Mar 2025 22:35:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [RFC PATCH 1/2] Revert "sched/fair: Make sched-idle CPU
 selection consistent throughout"
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Josh Don <joshdon@google.com>, Tianchen Ding <dtcccc@linux.alibaba.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "open list:SCHEDULER" <linux-kernel@vger.kernel.org>
References: <20250310074044.3656-1-wuyun.abel@bytedance.com>
 <20250310074044.3656-2-wuyun.abel@bytedance.com>
 <CAKfTPtA3k7oXqKjX6bNsjG1BCjq4TB6fWvTH1RV425iK01xA2A@mail.gmail.com>
 <e4ad9841-5ba2-4704-95f2-3d8affee9afa@bytedance.com>
 <CAKfTPtAqBgCAoTaMv3_7Xguo+jtpBgg5EXOeUBWfMyPY8YDkJw@mail.gmail.com>
 <31574ba7-a04f-49fa-aea8-a0a751915ecc@bytedance.com>
 <CAKfTPtAHEtyrQ0VfrC6iHR8Rs5AjCOFNbMiVHzFzHTU00vjeVg@mail.gmail.com>
Content-Language: en-US
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <CAKfTPtAHEtyrQ0VfrC6iHR8Rs5AjCOFNbMiVHzFzHTU00vjeVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/19/25 6:58 PM, Vincent Guittot wrote:
> On Wed, 19 Mar 2025 at 11:36, Abel Wu <wuyun.abel@bytedance.com> wrote:
>>
>> What do you think to choose a less loaded cpu if no idle ones available?
>> So the wakee will probably get better served, and also helps load balance.
> 
> I'm not a fan of adding more than idle selection and we already
> compared load in wake_affine.
> So we should only look at a cpu that we can preempt immediately: idle
> cpus or cpus with full hierarchy sched idle entities

OK, I will have a try. Thanks!



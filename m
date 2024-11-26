Return-Path: <linux-kernel+bounces-422331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1322F9D9808
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 14:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C44F52820C1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 13:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC201D4605;
	Tue, 26 Nov 2024 13:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gZ+nKnx+"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ADC1D2B22
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 13:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732626522; cv=none; b=XCcQ2sl5uuuHVhqgigp2pBvrWMS4ejTwBr/N3dOhV6/nJxr11F4VQ0en1n5leKhJwfKKBftLSBOxRCU3/vARnSaS/MFbHJMtkiHRqdiGwvDBXFjhnZD4cp/rNX+rtPxolAWOAeoSer1q9gyxu/b8XXMUu8FUxQ66K1we5OpuBvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732626522; c=relaxed/simple;
	bh=jQHJQQidNbNUcgbt21fubMe8SqP8NtfERFhpsdEmuDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8pStt5ip0Q6feBqwa2vm0fKoOvxMXYpG99P/guD/CO057apX5m24DuCJfd6WL5gpFHT72mE+nm09Xghr7lN9OmlkFL+Ua9TmHl0TYkZ+D/oxIB8x17lWsoM2VJYX+0MvEL5peIgSqEt1q8AmllzLepimoQdgatU8qgwexxsi6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gZ+nKnx+; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37ed3bd6114so3331645f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 05:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732626519; x=1733231319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EU1FFuJWDKogHlWGs2wUOZ86NdWkE+VHCPjkTaTPb5o=;
        b=gZ+nKnx+1JrqlIN7NIpqKzAByijs131QXGQ7YJlRjpcGFusOakzqfOZbBdZTHfkMOh
         RdOtsX6SbnLvrYe3DLyJIT+NW9xqYb12/uX36fWYtvlpsWnL6faobVozkwcBwD3LYfVJ
         OuxciqndSn+LoepGzFfTGeEMtmVXAe2QXAyUYV2SMz+bDLAtcGu2b3MXlhOSWAEvENdw
         K/JJOwzVOnpbbejKBrUAucvNvk8+zinzYJWj3I0Stor1Z9vbqAqBsW/QoHt0AE2oIvl4
         tbDy1JbvROKjyfLO/bQGs8NJ2lOAMuk5mSZEh6m3mKKuKOZs0WzxWEH1/M7Zy+nQ2L5Z
         EjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732626519; x=1733231319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EU1FFuJWDKogHlWGs2wUOZ86NdWkE+VHCPjkTaTPb5o=;
        b=bTxzfcLllgOrYGfXL8Lz2WfAe4csb1JR4Q2znLUyFrUj1QP26jbDWygApi32ocODW6
         GbX9lH901Ud+lTlIVDjUK1Bu/6wnKRTMPE/zFMbt3AstRUQvIfpwIsSOlfDgRXEMiew0
         bwUohGZBW0NStegsuT5B5fwheagW+RWMiYqcQAIiWmLs+bs5OOQO5wIEi9jUycF9Fv1n
         0bRJf9opHCVWUsJL57Le7wZ2u+lLsumG1nk9JI48MVkcJo/K7zjKQaIGvMO+ISyc0Ihr
         aLdjYrKE05GBeUzP7fDAS2foFrVgDdW8LLG85k+u6g2uFoRRnsXh5Ksxi44EyGJl8zRQ
         cl8Q==
X-Forwarded-Encrypted: i=1; AJvYcCW12jZ2Lp36OhPzl757Jkk0+JVz4KEjd775v0h3jQkpfmUS/8DM8ELzePNSOCFiB22fNobEtSrbsmhVIBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqPG16hC4FV8QaT8lJVTsFC49RPP3/kUXTbhIasPyBJAQ4M/Ax
	Ejq0V/V7f9lcf4oMZA6P06qsUkbg3XltQIgQoCw5TcLLMXcS0pQ3FSjCvG5mk8g=
X-Gm-Gg: ASbGncvTpK5xd9jTwFaxsJk37jCXDz3ckIrLzXrIGkFBq91h22gK+acslHXgLuvw1r/
	mJPd7hwQohAOtIhx+J1iV5R+8z9bwr5VXbz1AYqWQIOw1+nRZ3fKMImAXtQmycxdHMh2LDJGPOw
	ZVjHIPEX7IxNsUCVHyaOnrJRPJ6MDEHJ+/QlUDCItemzN3Pew8olDfMzmCtZ3klWAbqObyj79NI
	RLzeV3teKUMPQ4LMvEh7CX8bTnkbjgfnaEj2ThVyArUD/Bf3z8=
X-Google-Smtp-Source: AGHT+IHIHEiY4LNIwECV9uQMLGLQvbtYi3+I3aK0yZuOUqtailKy9apEj3gRf0AYBQIaYBa4yUIKKA==
X-Received: by 2002:a5d:64c2:0:b0:382:2a2b:f81e with SMTP id ffacd0b85a97d-38260be4aa2mr12232395f8f.51.1732626519211;
        Tue, 26 Nov 2024 05:08:39 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fb2683bsm13438746f8f.48.2024.11.26.05.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 05:08:38 -0800 (PST)
Date: Tue, 26 Nov 2024 14:08:36 +0100
From: Petr Mladek <pmladek@suse.com>
To: George Guo <dongtai.guo@linux.dev>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, shuah@kernel.org,
	live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, George Guo <guodongtai@kylinos.cn>
Subject: Re: [PATCH livepatch/master v1 1/2] selftests/livepatch: Replace
 hardcoded path with variable in test-syscall.sh
Message-ID: <Z0XIVBrwRJMB594e@pathway.suse.cz>
References: <20241125112812.281018-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125112812.281018-1-dongtai.guo@linux.dev>

On Mon 2024-11-25 19:28:11, George Guo wrote:
> From: George Guo <guodongtai@kylinos.cn>
> 
> Updated test-syscall.sh to replace the path 
> /sys/kernel/test_klp_syscall/npids with a variable $MOD_SYSCALL.
> 
> Signed-off-by: George Guo <guodongtai@kylinos.cn>

This has already been fixed by the commit 59766286b6e54f8ad33
("selftests: livepatch: save and restore kprobe state").
The change reached the mainline last week during the merge window
for 6.13.

Best Regards,
Petr


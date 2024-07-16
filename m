Return-Path: <linux-kernel+bounces-253774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D40439326C5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 14:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B91B1F220B3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 12:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB71519AA72;
	Tue, 16 Jul 2024 12:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Xq7LEDcr"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF2A19AA41
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 12:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721133896; cv=none; b=KE6K5LFYRL6KTEU8IwNK4Qab/5vrEi4EWL4KnM2sQSrqY4Myf0ZUsKFGFXUAt4TRZ29B+e9jv3regmUhgc9EHAMWEoXHqz7kVUFrOJ23J8XEJQSrRIJRu20frAMfYprKYMi+jdya2ISYf/ix22AixMWNJKoK07on7QGt7GdIPUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721133896; c=relaxed/simple;
	bh=dwdxgv8V8kbKAJ6WjEKzHMmmBgdH2PPjzi17SlmdtD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R3rHqSYz5Z2E8f1Loef7oGo1uhMhFRt/83t+2s9XgE0G1JtBjRk4b524n10bIUbDmrBqT1A+BdjpukgVTJI2A7vPC4TGf8Pe/GLXO0lT0PPP09sE88rRFZLztWwiIsn3mRn3UE+E0ptG3CLz9iJcZI8hMHZYhW7bgdj2uOPY9rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Xq7LEDcr; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-367a183df54so3697115f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 05:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721133892; x=1721738692; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zyK0V5xn54DTZJ+xeJki1ggFMkkVmgI9Zw/UgD7lbLg=;
        b=Xq7LEDcrAvxZiLRt1MW+FKltSN/zYPZfrplhGLU+HMWv371zqhzeAdwjebInwxh8jv
         O8Znq0oGV1M8+w1AWlP3ykqPovEsfLx6cSLZvXZGp2RuIh19v3zpIxhfCbcO4mpNu7xZ
         VxSy4EcigezuonOTvDW6olHX0XLL1R+mFHx1112tzKs9P4YqkYadODGPPW8bwa1RmeYe
         DBENSlkJ5QvzqVcl9zHDXW0uMWhaQce8hDu7Gb+6X/PExT1qxLfNHUSP8oTdYQYQDZgI
         dLneiPVb0J8x/+lDiWa6+K7TMzn4PmphgpPHJgprQun+d9PEOrmWH69d0gQUclK+RCWt
         PPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721133892; x=1721738692;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zyK0V5xn54DTZJ+xeJki1ggFMkkVmgI9Zw/UgD7lbLg=;
        b=ZvbeAFd3e4ETBqBAKxeuRV0hZ0WcPkHcideMfnoDSaLa94sIWkO30WhKl6szdSTWgB
         V07vDwMzZZ1F8klOgx5tT7XmSVA/6cH/Ms2yQMb+hytSy7Ur9vI6Nsb9bJPcR/h9kzel
         vtq4r87cB/seetw1PBvmpMEtuQLJJVyL6dldlGHAtLjKvy1Q1HuiYo4G34WK2AmATqbc
         AtkJjzXHg1Gbgf34Ihxh3d3yYN3wZd25T568U2mQWeeEBvJ/Yx5kZNQD1bjX98uAk1Hq
         +gAGYiHJW/1mbi5hQFB5jozCmh4qjt7hhEDZKhgDuSprN/sVLwJafpwszaITNiKHOd8x
         ga6w==
X-Forwarded-Encrypted: i=1; AJvYcCVE2yADkt/i/zmYLZE3ABtrB6x1rRK7wSYl/S//xYS0hJa+EcZMOBJLT2qg4KXMj1lfBA1GN7sC0uENvEbZ9KZhoyyZ50ox2LQeuSot
X-Gm-Message-State: AOJu0YysB+KULDALrMwdZH2dKJ4ceIoZ2+ZvCI7sa6O+NKr8tK1UnElf
	ULVumlYFdEo+oVhFhy4qkPe/GTOH0mGDYzjoavQpjfC+jDViyB0KZX3rmP4NQZ0=
X-Google-Smtp-Source: AGHT+IG4JqpTiP+3C1HhXZKcAWP+e9nawyIqUtu+FoJG6WPJmyQbdnc3UldtOHL9uNgvdNnfCJNAlw==
X-Received: by 2002:adf:f0c4:0:b0:362:3b56:dbda with SMTP id ffacd0b85a97d-36825f72505mr1289464f8f.9.1721133891884;
        Tue, 16 Jul 2024 05:44:51 -0700 (PDT)
Received: from ?IPV6:2001:a61:137b:5001:be5a:c750:b487:ff1b? ([2001:a61:137b:5001:be5a:c750:b487:ff1b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680db04841sm8924139f8f.101.2024.07.16.05.44.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 05:44:51 -0700 (PDT)
Message-ID: <3073c8ce-1923-4816-a442-41b4cc333af9@suse.com>
Date: Tue, 16 Jul 2024 14:44:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] usb: usbfs: Add reset_resume for usbfs
To: Alan Stern <stern@rowland.harvard.edu>, Oliver Neukum <oneukum@suse.com>
Cc: Hongyu Xie <xiehongyu1@kylinos.cn>, gregkh@linuxfoundation.org,
 brauner@kernel.org, jlayton@kernel.org, jack@suse.cz,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240711084321.44916-1-xiehongyu1@kylinos.cn>
 <527927b8-9475-47da-bf2b-7a5d9e81e470@suse.com>
 <9ef72886-13b8-46cf-a0aa-54dad36102e9@rowland.harvard.edu>
 <2a80d11d-029f-4e7e-9a8e-3abae1034add@suse.com>
 <429eb27a-578a-4208-8ce1-89434b8d739f@rowland.harvard.edu>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <429eb27a-578a-4208-8ce1-89434b8d739f@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.07.24 16:22, Alan Stern wrote:
> On Mon, Jul 15, 2024 at 10:53:14AM +0200, Oliver Neukum wrote:
>>
>>
>> On 11.07.24 16:41, Alan Stern wrote:

>>> Agreed, but the solution is pretty simple.  Because the device was
>>> suspended, the userspace driver must have enabled suspend via the
>>> USBDEVFS_ALLOW_SUSPEND ioctl.
>>
>> The whole system could have been suspended, in particularly to S4.
> 
> You are right.  I was thinking of runtime suspend, not system suspend.
> My mistake.

This is at the intersection of several scenarios. That is a good part of
what makes this difficult.
In principal I think we could get away with checking for a flag to be set
at reset_resume() before each operation. Elegant this is not. Yet, it seems
to me like the race necessarily exists and is unsolvable in user space.

Furthermore in the long run, if we want to use D3cold in runtime power
management, it looks to me like we would want a second permission ioctl
for that.

	Regards
		Oliver



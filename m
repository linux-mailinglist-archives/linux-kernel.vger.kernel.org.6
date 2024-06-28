Return-Path: <linux-kernel+bounces-234451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 412DA91C6CF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9AF4B23800
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 19:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E8A76C61;
	Fri, 28 Jun 2024 19:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QXNmpUmz"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB2074059
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 19:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719603956; cv=none; b=t7FNfyTGfY70WLPsmISC+0t4KHOKFGQ8jAHYpoWeJhHBzwiPbPEcKD6tt2zAvbJ4/RtMargxiCxJIwCq6n8WDbsi1gCeb1/uNOkOu5IqXQZCvdVSgsfKHvZ1pyjUl1t67BoKwnBriJHpaBeVuX1dcyTMIsjoB8ywJ/JtNOm5rbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719603956; c=relaxed/simple;
	bh=H6sDvQFpHpw0Rc2a1DhQlzCPAHSVJqQJGxNnUBOfnwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GEeUYYSIzhsQG6NXWA4t/hbF27zlR88nTZ8GJ8YklKdtAtAbEAu1iSEZ5eQI5Gm5QH1SYpUms/zLJzxjmlFx5XGqVr1cNpuoKbWYUC80mNXEE61lU1+6FP6TjZJj5jqR+em8OL4JP9UViRggmUJbNIpccrMNkVtYIW56/BUU6m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QXNmpUmz; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7f3d4a92857so1817539f.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 12:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719603954; x=1720208754; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wFy2b8oVABYcj3xshUopT/e34dAfFxSX3qpBpatyN90=;
        b=QXNmpUmz/+7nvRkY9A68PsYZqslHEj7zcFiZ2xswe7DcNVEFcmI7k1f1bKVRe8sIzP
         MArhrtsQOztYStHymKNDFBYxRu5PwAtSABJsB4I7sFZ2a2lbzFMdl2XaXajINtqFJoYD
         phLxRbVUiCbwyrkhgBUPlASizoPg++qz/kUpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719603954; x=1720208754;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wFy2b8oVABYcj3xshUopT/e34dAfFxSX3qpBpatyN90=;
        b=ZR268o8fYCwB+N5nAasktdqHeHlDS+HBdrL6mZAv/akS6xCLhKqXvf/3g5PQL+lYlU
         XXXE4qgG8LJLc7RArrt7KvK2wAuihs2Rn5R4rsjNvl2Vd9LNYlqUenhwA+/PHCSFmJpo
         +Idk0T5QcNmzU25xJnDQhWexl74qFYJa5PBXa3i0NBsIN/lBrasyuiBbE8iOSbuuzkfY
         y4hfSuIH8jeeNSaZ+Yxc/1XQjTLoRODtCmoVE6ECFjZLZPyQULInHFeFKZMknHHwUswU
         178Ee2po9UQa0bKitcoppF1J4mH3oOvcgtp14dHnSUbXxHOFU3Q694f814cDOfUhFVyM
         q7MQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAo/mf/rBkfpaxUJXlBeRoXkJVQENZ971ItX4tzlh9xgDHxstn25oZ0IEe0kB5mmRJDpvRuX4YNtmKTKyaotTk4OBToFTDDjf/ylrV
X-Gm-Message-State: AOJu0YyPuzgz+Kty0Ty65omMknwjf928UPJTiX6l2btu6SXrzYDXrG1R
	NodTnqjFQNGkQjF8aT1KUqai84GMbmGahcYogmdIG7IiBKUAZVq+3SL7HJYJDZI=
X-Google-Smtp-Source: AGHT+IHPYjY418V10PP89PM7T1NNet/PvWH3Qy86QLmNXQ7IR7y3dgq4cdm/cyZF8VR66Lh172wBGA==
X-Received: by 2002:a5d:984e:0:b0:7f3:9dd3:15bf with SMTP id ca18e2360f4ac-7f39dd317famr1651334739f.0.1719603953855;
        Fri, 28 Jun 2024 12:45:53 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb742bd3c8sm687734173.147.2024.06.28.12.45.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 12:45:53 -0700 (PDT)
Message-ID: <f1261f1c-abbe-49e4-b0bb-b72af367da7f@linuxfoundation.org>
Date: Fri, 28 Jun 2024 13:45:52 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cpupower: Make help command available for custom
 install dir
To: Roman Storozhenko <romeusmeister@gmail.com>
Cc: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240627-fix-help-issue-v3-1-85318a3974e4@gmail.com>
 <c9df6637-6055-4668-b80b-a1a6e6be445e@linuxfoundation.org>
 <CALsPMBMeo5E9ZND0bPK089VHBZnybsigkvoC2r8BLCTjYt9QFA@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CALsPMBMeo5E9ZND0bPK089VHBZnybsigkvoC2r8BLCTjYt9QFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/28/24 05:30, Roman Storozhenko wrote:
> On Thu, Jun 27, 2024 at 7:33 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 6/27/24 01:49, Roman Storozhenko wrote:
>>> When the 'cpupower' utility installed in the custom dir, it fails to
>>> render appropriate help info for a particular subcommand:
>>> $ LD_LIBRARY_PATH=lib64/ bin/cpupower help monitor
>>> with error message like 'No manual entry for cpupower-monitor.1'
>>> The issue is that under the hood it calls 'exec' function with
>>> the following args: 'man cpupower-monitor.1'. In turn, 'man' search
>>> path is defined in '/etc/manpath.config'. Of course it contains only
>>> standard system man paths.
>>> Make subcommands help available for a user by setting up 'MANPATH'
>>> environment variable to the custom installation man pages dir. That
>>> variable value will be prepended to the man pages standard search paths
>>> as described in 'SEARCH PATH' section of MANPATH(5).
>>
>> What I am asking you is what happens when you set the MANPATH before
>> running the command?
> 
> It adds the custom search path to the beginning of the MANPATH variable.
> I tested this case. All works as expected.
> 

Let's try again. What happens if you run the command with MANPATH set and
exported and then run the command. Can you send the output?

thanks,
-- Shuah





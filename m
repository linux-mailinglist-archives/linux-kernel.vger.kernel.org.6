Return-Path: <linux-kernel+bounces-323733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E67B9742A4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 20:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF060289BFA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22941A4F39;
	Tue, 10 Sep 2024 18:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NNjTfkd/"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74F61A4F31
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 18:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725994205; cv=none; b=Mlsvi5c2jC7gqUdvbJDNK/kIMoV0RLt8bRqwJXHnfqh5LZJTR8YI1HyV90SmfPEBoUldy/t/j84T4kRy4sGZ4UscajOA0e96D/eaPUHMzdenXJKJcbk6gzTWtM41moxQ5WN2uCRChMVL9DS5faRjQIE2o8BuDf5QHbGwolhtctY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725994205; c=relaxed/simple;
	bh=itBQXuelZA75Po5d9GzHrmHgnyq5aLaPbElZSW4ZNp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oe8kbUS1gV7IGushRrzLVEDFHWYgfwnaCytj562ouQs3S5QzBl/+wgws3pViALZ8l9+ICRrk+tZ4LFlcVE0uaaM6+WW3zC5DghxgY6XZfjgFsKF8UMsodMCWql8WaTWVTqrsB3WF9CwYx+HB1r3ZEkUHvhxWFXOfI4w+apsGoos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NNjTfkd/; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-39fdd5c44d3so26392935ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 11:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725994203; x=1726599003; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2xzLBxLjgDj5rpC/iK1MnqiUkc34ZYC9aNRFEI6xVyM=;
        b=NNjTfkd/VBvsEsDkvZs4/SFKOlXxY9n/nJwRU4T/Oh1dkJVSiY1dd0wOYZuLBRCjGh
         shqIRGc+oAy9hftapFPap2qFzqXodqlrjAOBzo03SFegy52EDqPRcpVh5LRjrIal2ex+
         zQLN+Ipn3WpoREZ4JaDBbzPfuEV7CfP4zqYtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725994203; x=1726599003;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2xzLBxLjgDj5rpC/iK1MnqiUkc34ZYC9aNRFEI6xVyM=;
        b=wiXvnRkmWxYoi5qK0G2RJPwJwF+ALJ8ZU0R7PKFtorFS3YTW23w420a8/871REN/mZ
         PpDUzbDhQJ8cYB6LsuGTUIRnIES7Rmd1cRYeit6hg7PGa/PQFJ/U8i9Z1ItLTWHJ76fL
         pk0Z/IDQsQMJJlzYW0xiDGnNJZOOSyOS0x4I7a+I0anpAR2SER2jad4EATnGf4Av6AKi
         YwjdYxzGqzvGSjRxdRuewyGXMY8X78jvxL97U4U6SpH9+ac/LHThDYBsH0nyH3i7WJVZ
         nCKq+bhTlPUxC1WkFCzUsU8GzYHNhVWGJZJrd0IhpC+VBrpFA5jO/mG2QApx2EibqEly
         Hr9g==
X-Forwarded-Encrypted: i=1; AJvYcCXmhGnc9I8u0Ceuv1vncskFat0DxZIMjilui/BHYNzg1MUzzcf8EXlMNNnpZvePv3y5o+dh+OU9A9YKWNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJpgK0EJsTYX7vAzGqJPfqCrwKgy6fJD+vKSeAVCc1VpIpYOs4
	1xYmtXcm/Bj+Ne5FCGoNNLXTyKxJf6Mv6aVClx9FUMGyFJxf20aMDeJSSn7r1U0=
X-Google-Smtp-Source: AGHT+IFDdvfVtJxuoA+NPIZaRMPtLiYE16oR91YzbeNcdA/bJHDFPaffJkkcudyfvCuPdeiV0K22Gg==
X-Received: by 2002:a05:6e02:b2c:b0:398:36c0:7968 with SMTP id e9e14a558f8ab-3a04f0758camr187994025ab.6.1725994202880;
        Tue, 10 Sep 2024 11:50:02 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a058fe56dasm21533775ab.52.2024.09.10.11.50.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 11:50:02 -0700 (PDT)
Message-ID: <bf48db12-1e97-4690-b733-bad6b2363edb@linuxfoundation.org>
Date: Tue, 10 Sep 2024 12:50:01 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 2/2] ring-buffer/selftest: Handle meta-page bigger
 than the system
To: Steven Rostedt <rostedt@goodmis.org>,
 Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernel-team@android.com,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240910162335.2993310-1-vdonnefort@google.com>
 <20240910162335.2993310-3-vdonnefort@google.com>
 <20240910124555.180428eb@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240910124555.180428eb@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/24 10:45, Steven Rostedt wrote:
> 
> Shuah,
> 
> Can you take this through your tree?
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Yes I can take it through my tree.

> 
> -- Steve
> 
> On Tue, 10 Sep 2024 17:23:35 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
>> Handle the case where the meta-page content is bigger than the system
>> page-size. This prepares the ground for extending features covered by
>> the meta-page.
>>
>> Cc: Shuah Khan <skhan@linuxfoundation.org>
>> Cc: linux-kselftest@vger.kernel.org
>> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

Vincent,

Can you please rebase these on linux-kselftest next branch and
resend. This patch doesn't apply.

Also please fix the subject to say:

selfttests/ring-buffer

thanks,
-- Shuah


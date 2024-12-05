Return-Path: <linux-kernel+bounces-433831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8489E5DAA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EE81283F88
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F4C225772;
	Thu,  5 Dec 2024 17:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hNErXSM+"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8688E21D5AC
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 17:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733421121; cv=none; b=LGtBUGh+vzsL5BXUDR7u9JF0xPf946Wo4Ub5jWmFH91pM3wdNzOkMz2p3ZrFD9hqx9kJq2ckKOjhXQAlbl8B3FZYz2TQKiwXQMUwNxKHbOjdHqk3HSEH7rnSTq72HQrB6DEWCRn2mfYxrpgDND7mHSSIOMWr3CHGPCANc7RfbdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733421121; c=relaxed/simple;
	bh=7MoIFK5OGXq3gDhad/EY4fgDc+nrvflIniaIyfUBSuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tEMWpo18khSdbwr85xf9iGhe8wXC9512kqb4NgBl3AiQXlYWAolbZIRws8AsyCejz4IhGuO6Kv0BqCL9Pib+3b1elzLhnyXjyQssHuoRb5hfungEYX+7AnnRAlgzn/FjdOTY69FkoAmYsB6Z4fFZPoS0KpJL//DHoR5CW42y3KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hNErXSM+; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53dde5262fdso1603274e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 09:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733421117; x=1734025917; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z5eWK/vs7fqhFUwAujMxMk12h0AxsQYVmA9NF533vvU=;
        b=hNErXSM+MXC4WHrEc4D09+FSQqOowyS4ijI/q6h7lyB/ywrz1L58b8VfGBOTypHU9n
         +QI3BQtq1tybGDxnNYhHmvnH1v/XPj+BjTet6hxTnXBSoULsWgpGdyr/wYBZMwyHY9Qv
         ZprTTLvhqhx8vTazCaoaWvnolgaD+XhVWVCPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733421117; x=1734025917;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z5eWK/vs7fqhFUwAujMxMk12h0AxsQYVmA9NF533vvU=;
        b=YEzd1PXb+6Z+tmON381e7qq/JKdeqfa27xPlQnjte2jykR1dQXCIpPAT9ySjX4bizb
         n9pX+Xnf7wtf9CPxhldU53Q9IjdKGWkV8FFPE6lkE7tU014ZDf8LD5TKbRqIDumc8G+x
         hLEbG3X3jpFvfBNwwZ6oStbteS1bks4L9JlepAW87fhTP6Zg3utZk/lJEMTfj6sJNbPB
         PGVUz82HJx5EgMNMq7YorBkjhEmn/oPTaZ3Jeb7qAJPszRVuhor1aJ/GZMqziFvexuDf
         +wgABJ0PYQBobFg2PSTj6v+P3X0yK6dOYzQMMyI2lsFmdyYnz32CDmrO8+s2dG1TfMnV
         Xy4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWAgg5GoKPusrZbfDphM13cz9JSZujdW08MIAFAAYUdyKwbNLNCzxBGZ68MvhXak6K6azNEi3LmLonr/aw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVJHfvzfio5fwf9IoD8+Kk82Zg7suD7aWgoTP4DrSjJvXazI20
	V4Cwm1xn3oL5NAi6qkbQbp4sVnXHz22BNZQUVlu+Cjowruzd6WnxsILrF00aZblzKuqzb4LRiR2
	n7Erxqg==
X-Gm-Gg: ASbGncvw2bJUGNFLFFleA7uFHxIgvUrkjxjMaseGQy69ZntVYlQGum3wonmpKhU3X0G
	SzTwHR2N4tY21bVBP9UMwbCEymdZOB61JYvEDGS278HIx5q3rahzZTNXfy9IZgAKX5PNwpjSYYj
	ZIxkil/lBWDQWZ8wdPh14EQxYo6O2EghCzIAxOlrwEXIpnDB0VV5mg2UsHHYeEorn5935WpJGCR
	tbTw8KoQ4tku6gLFQJ2U8IEqOb31Hu4xD704hVqYvXc7zzKdHvNz44rLB+aquy2XfSirXKZYISS
	eb4gV9gatwFJZFiI4X8wAQf8
X-Google-Smtp-Source: AGHT+IEpKNkV8t2VC1dbPH78inrW3yLkHkToL8Le576ODdhIHCLiF0dXx+/3rnJwnrL3N8D/ZUPAlw==
X-Received: by 2002:a05:6512:3f2a:b0:53d:a58c:c5a4 with SMTP id 2adb3069b0e04-53e12a22f0bmr6339823e87.40.1733421117518;
        Thu, 05 Dec 2024 09:51:57 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e229ca47esm295179e87.264.2024.12.05.09.51.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 09:51:55 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53df19bf6a9so1364497e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 09:51:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVSpEroka/dQnc48PNfkaLKrA6HJIb98Ur0VNWKsBGqaFXF7xZN9yC0O1QseoL09lmFYojjQAHBp2qON1A=@vger.kernel.org
X-Received: by 2002:a05:6512:6c9:b0:53d:e4d2:bb3 with SMTP id
 2adb3069b0e04-53e12a2e4e5mr7858256e87.50.1733421113830; Thu, 05 Dec 2024
 09:51:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203144743.428732212@linuxfoundation.org> <efbda6ac-9482-4b37-90b7-829f2424f579@cachyos.org>
In-Reply-To: <efbda6ac-9482-4b37-90b7-829f2424f579@cachyos.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 5 Dec 2024 09:51:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=whGd0dfaJNiWSR60HH5iwxqhUZPDWgHCQd446gH2Wu0yQ@mail.gmail.com>
Message-ID: <CAHk-=whGd0dfaJNiWSR60HH5iwxqhUZPDWgHCQd446gH2Wu0yQ@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/826] 6.12.2-rc1 review
To: Peter Jung <ptr1337@cachyos.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Dec 2024 at 07:46, Peter Jung <ptr1337@cachyos.org> wrote:
>
> Reverting following commits makes the machine again bootable:
> acf588f9b6fb560e986365c6b175aaf589ef1f2a
> 09162013082267af54bb39091b523a8daaa28955

Hmm. Thet commit

    091620130822 ("sched/ext: Remove sched_fork() hack")

depends on upstream commit b23decf8ac91 ("sched: Initialize idle tasks
only once") and does not work on its own.

         Linus


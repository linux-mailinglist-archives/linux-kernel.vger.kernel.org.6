Return-Path: <linux-kernel+bounces-350369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB9B99040D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B10231C2092B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 13:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158E52139D4;
	Fri,  4 Oct 2024 13:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b="RBi8XgyW";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="f7SyFF7S"
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F03212F0B
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 13:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728048143; cv=none; b=KKZPTB/YL8u+1MqeFdNxd0soY0lyNxB9F0sSh5QTjG035cBkKz3V947y7YaRy+G5aFrFF6jlPAnsMBAAzTick8ycYkaOhZcZgdq+KxBWpIITDTnfY71TqHX0cphCHQ5WrIKNgPrfeBDJLtVDYFqvpnCTolLDwFLe+lhYDQagCrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728048143; c=relaxed/simple;
	bh=d34EeO+GWTvbA07bjrTFP1vNGB2N2vUnQMU6mQtG3dE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pyZDUa+4SJKVXJtwRPaHSkE6SQy5KfyzmAkWX1FF9GZIAtlKsKhXvO/BICvXETqV3QDryv8ZNSfTLnakp1MY02mB1ysdmBrLHqA+E/sIqya2LsCnufpV/UP6+kBSdvtQr1UzVfpaBR7G8dUaaHCJj0YWgRg3csyxgYBH0A2qmPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev; spf=pass smtp.mailfrom=lkcamp.dev; dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b=RBi8XgyW; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=f7SyFF7S; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lkcamp.dev
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=RBi8XgyWRaabNeWpxU3NJWrdZol61vjV0w/LyhPBc7n4ZC0l2wqaRIo/zPeOU2Zgtx+vJ7QX7DbMmTFkw1P5zQd7+KvgG0jSd4BcjgDeHL+G7Kbaccbl4nsZJanxdnsWuT7A/af5SIHvLN6gVsGVkIJSFzwTTwms0J/VTjx/UOMbmASW9bEqapGmsHlN1tNjNVDhDxwuvBamo6xnSdWn8JdGB1UI0uTjToPxxvKQ/rk7CVtOqIBqNW5PKXgGdzcorlX4O/WndQqplmon+nOoE7kZqDIxYzSvzHgwQfUA1Axj+ubCyxXn55kf1ygoKb3NnuyeBhOsGAMlxoFQnwLxrA==; s=purelymail2; d=lkcamp.dev; v=1; bh=d34EeO+GWTvbA07bjrTFP1vNGB2N2vUnQMU6mQtG3dE=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=f7SyFF7SggfnkT5XuU6DhyaQJuhe994HsbW6riATX6001EiRNb+jbzxa1MrFMPStNgaaZi5LWl7nrZRaM36VcCsPHPC8u3JUuItAixDiSGwKsd0oBCucWNadDz5npT0mbEIgF0PMWDQ0GF0p0FqiGaAcRpBYU1JaFyz1vZZlGju4sbhBARAvvVWnHSB5LpJfxZTB0noAI24IFmiHlBA96avOisc4zkJu5RqpHZoyL+9ZJCk5jebK/znDvN1VMTp4/yG5q+e/jxEgHjDwPYqObqqmn23HnqtmaS5eqO9YhYkAvn26uuGcrmtyY1KDa5fuDwcTaguWP3cXn4SuW50ZDw==; s=purelymail2; d=purelymail.com; v=1; bh=d34EeO+GWTvbA07bjrTFP1vNGB2N2vUnQMU6mQtG3dE=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 40598:7130:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -453732278;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 04 Oct 2024 13:22:10 +0000 (UTC)
Message-ID: <c4ec47c7-5718-49c6-b5cd-53e5d61420a2@lkcamp.dev>
Date: Fri, 4 Oct 2024 10:26:17 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build failure after merge of the kunit-next tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: Danilo Pereira <dpereira@lkcamp.dev>, Pedro Orlando
 <porlando@lkcamp.dev>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20241004141146.3ce262b1@canb.auug.org.au>
Content-Language: en-US
From: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
In-Reply-To: <20241004141146.3ce262b1@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

On 10/4/24 1:11 AM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the kunit-next tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> ERROR: modpost: "utf8nlen" [fs/unicode/tests/utf8_kunit.ko] undefined!
> ERROR: modpost: "utf8ncursor" [fs/unicode/tests/utf8_kunit.ko] undefined!
> ERROR: modpost: "utf8byte" [fs/unicode/tests/utf8_kunit.ko] undefined!
> ERROR: modpost: "utf8version_is_supported" [fs/unicode/tests/utf8_kunit.ko] undefined!
> 
> Caused by commit
> 
>    94d8a0976d2d ("unicode: kunit: refactor selftest to kunit tests")
> 

Here should I change the commit and send a new version of it or should I 
send a new commit fixing the problem?

> I have used the kunit-next tree from next-20241003 for today.
> 

Thanks,
Gabriela


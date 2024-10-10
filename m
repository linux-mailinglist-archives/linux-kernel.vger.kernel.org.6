Return-Path: <linux-kernel+bounces-359170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F7099884C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 949611C213E7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E48B1C9EDD;
	Thu, 10 Oct 2024 13:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MzmYPYUS"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EEE1C9ED1
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 13:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728568213; cv=none; b=Pxz4JpYB17ICua8iyie6bcH+jk26G4uNVnLsXp0jfk4E8Gz/0n5C3Wqc5W1TAP+R4GiXAksUmue8+Xl0ntpmA2i1f6FKbZMw2Dl9/Y3Yyp96N5uPW4OT7P4f7RmrZesMxWVxGQJsb9CJKoENExxA6RCSzeQmxsBIIvzkPaC0k+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728568213; c=relaxed/simple;
	bh=vXSpa8/ztwFdblYzjZfPeAy65gA/yhbEbIjjTnCiBrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CO9hE4NvXmHUVgJnxfRg8QF55JnyPfKk6rF2/WPyrKLtb2DBby3u7T+/BVhS9o2zUpsinffx677gUvle5ggcNfW8OGRu/kbc9RGPUlaHTUHIC9tsU2STO0WtYWhUllUYgbS3X4d2pRRmG9vpZHkMm9JMIphwmyRaaLVwO2w3fqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MzmYPYUS; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a3a3a9e4ffso2961165ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 06:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728568211; x=1729173011; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lExNIi51K2j3D8nATL62y18ayPUOjQ1BwEMnlcOF0zo=;
        b=MzmYPYUSiMZKcy+gUsRdWDQrZAlRu5Veg4iG3BcPb5cQggBNT588dlKtHJZNiqr+sw
         rhkJVwHSjLF4S7l5ZVL34OJxw/TG2l7shlmEBJ5VuGWp+HNwJPS0l5hh+5bpx+SKG3U1
         UcgZeuIIipKlHHkyx1K7x0ykn0trEksn9EHwMgfNcF2jgISSYZqfTz5ak4HTUiCgsL53
         nIJqtmTlH5Eb8XlHFWvQ6AUMYPr4zW3AGamh3yED6HzQsQn5rR7+2ndvD3nJ8KHN1/jK
         KJUeCDsOo1qgtMVvvEdJeFDvO8DvNZAfxAwdb7IRpvPSLyuXiGVtiUrGWzL/Y+MIBJEO
         ieGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728568211; x=1729173011;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lExNIi51K2j3D8nATL62y18ayPUOjQ1BwEMnlcOF0zo=;
        b=YlPdV7S1V0KdZZR0u5cv3AtzAPawHJaVijHQN6Tj6BfV3hKMlqW9KyjV66akfbgKR+
         rgzyx/z/WR5dETyVc19qHDTfRak/Ce1VGZhh+N9xoIoJ5SVWq8Jy76NWFC+eJwJbMfi1
         l9ODgfOwl2puA4W8H5jHYZBFtbch8KOzkZBVaUaomfrBZa4SnLp49bW8Npi4PPznS6XC
         r3GxSz3tAh0Xyf0Lm6v5/z6d/WOAFugX/JlJj4q3CgxWeMJg0gwyG35XFo+mMt0UItLh
         mG5GhFuBg4YJ9gO92s9EWHkGneIp2AUkWIsD2SF8FYfk2KbDxks3SLKSwkjDx1EPAtVB
         4LUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEzJBxFXt+HS2Z8U+xIocFLP/erAuWu1foWS7UL2wH8jhh4y4sgAojHBGMo2bQXqVZf/SQeKIVCmOos8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6sLDiVfXjDqmpFOR3OYhq5aE1W88d8PmmpRW71JiVTm0EffK6
	q99kJLsCU2vZZh0wmzfKzPbuERVMwZfOK7doubnZUI+nUji0euK8sRFkD6T8eDQ=
X-Google-Smtp-Source: AGHT+IEeR69NBR8oq0nQoLaOvleeI8vQnB6Q/r7lACE3lrve2GJIB5H29drPuLqYyHSLZ0XLqozqOQ==
X-Received: by 2002:a05:6e02:3dc2:b0:39d:3c87:1435 with SMTP id e9e14a558f8ab-3a3a709de06mr24168715ab.1.1728568210945;
        Thu, 10 Oct 2024 06:50:10 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbad9b0e90sm246561173.15.2024.10.10.06.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 06:50:10 -0700 (PDT)
Message-ID: <842a76fe-3d6a-4846-83da-bb113634b8bc@kernel.dk>
Date: Thu, 10 Oct 2024 07:50:09 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: AMD zen microcode updates breaks boot
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 the arch/x86 maintainers <x86@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <91194406-3fdf-4e38-9838-d334af538f74@kernel.dk>
 <20240928061038.GAZved3hMSU3XahWrJ@fat_crate.local>
 <5fe1e264-c285-4988-b1e3-46771d07172b@kernel.dk>
 <20240930044313.GAZvosYZF5mHi2OZbC@fat_crate.local>
 <d7aff674-ad92-4a36-9ebf-8d3c42774723@kernel.dk>
 <CC418B80-5ED9-4F64-917F-BA6F94130F83@alien8.de>
 <ad9638b4-0a4a-4cd0-9fcb-2690693da157@kernel.dk>
 <20241009091247.GCZwZJDwFETmN5pEGe@fat_crate.local>
 <77f16324-47e1-41e6-a9e9-2cb7cbc8d14d@kernel.dk>
 <20241010134613.GDZwfapaZ8AKp0n72C@fat_crate.local>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241010134613.GDZwfapaZ8AKp0n72C@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/10/24 7:46 AM, Borislav Petkov wrote:
> On Wed, Oct 09, 2024 at 05:04:23AM -0600, Jens Axboe wrote:
>> Yep, 0xaa00215
> 
> Found something: I'm not handling the stepping properly, below is a big diff
> along with debug printks. Can you pls run it and send me dmesg. I'm assuming
> the box will boot with it.

Sure will give it a spin. The box is tied up with testing for now, but
I should be able to run this later today and send you the output.

-- 
Jens Axboe



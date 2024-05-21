Return-Path: <linux-kernel+bounces-185196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA568CB1E6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 18:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F271BB23255
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C0574BF0;
	Tue, 21 May 2024 16:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Db7NzW+E"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB53D2E62F
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 16:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716307504; cv=none; b=eMJi2vAcIArqJDOc6vxbjI58kzoJjpC0/vp4NEbe0evI48FjKpTTS2kIPiMz7YvCK72n9qPftP2/0IQceSo+K9XX94+BmFc93kJwmF6OWIF1iNeIhe1y1XYd2LuuE34ipUOOgwvKWydKy6m/Wc48dQHgVCOSZH5lxQMVx4W1Oj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716307504; c=relaxed/simple;
	bh=bKdqkY8H9wTw5y+8oj6M+om12H9BkqcMweVk8ln1A/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XGLD4pkRk9dcTfn/7YiMixsXwPJISUZSJUFKnF0u1Ft7rq+tXkrZOfN4rk67Z1k5A467XaRRCLsEGrgZeUyf5UFeK2x1jbbRa4JEca9/ONZepk08Vi9ukR47pvnpkS4GQEPBmNp44snm5uwQCtJPAbVFMsuZ4amO4FdDha+5ugc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Db7NzW+E; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3711744c61cso479785ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 09:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716307502; x=1716912302; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2nt4NT2eZ7AdGPqZ8UIZ+5/ykmoqBj7Ymiyz5OlxoaQ=;
        b=Db7NzW+EBXUhuNcDgbMNrT0eqz5RlvT2kO+XlAGZeQ8CNgE6YmV9nXVVBFUF0l2nQ0
         7LVd6iNvRiDF5d5PkB5C57dAw6cPoYQWZyhafZ2v8H57HMHWmRUlEzhu/QtU5EhgaUOZ
         fZxkXJVQ11OKQZDKkwQIHk8HH8fFhPUYUU7Enn6/BKUNxm66nKrfSaYaohwAOZiGvtdI
         vtumnXT1wRh2KNTjhizQpoUuviH3xoqBfWL19ml0+S60lpIJ1saiEuWzNo8DZEJZanHr
         DeuIwZFUty3mkIib9nEAYcIrfFY4VJXCt+B1/sEgz7IbjaF8Mvz0pC74VGtKWalbduX8
         Mrrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716307502; x=1716912302;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2nt4NT2eZ7AdGPqZ8UIZ+5/ykmoqBj7Ymiyz5OlxoaQ=;
        b=FKhzEgmYMDkN8Ip0PGCKQbxjr/IF9NJ3cMylkmzy9eKl9POnAZ9uy/dUVN+KeStALf
         bYfLYlPCTN8bkkGPriFHwgg8oRxK9RCCvRLgJ+rleQhhILmOKzu7hI/ptYe7PCeTWZao
         u/u6zMe5YQ1NsGS0ZG71TRXUtj+qdWZEwGtEMjKVn3Vpg/INRSxUNDUl68kn8//atPEg
         8vRKuD2JbJNcIcbJRO2Wjs1cJGwUn/ZXvLcEXPlbjoF9jY43DNAjIuxDXJxrJ7Btj/sr
         I9rgB3821Pv4EoKCK6j0Fj5uu6UeGhB077iwUaWoavp7Yu9LAaT5R3lD91CKn1RTGOey
         +rhw==
X-Forwarded-Encrypted: i=1; AJvYcCX640m41Ap/2/sk9siC128TVZtjtsaDfWsw056L3AffRQu8ztTxdFKm3VUNsNtr85FWZPTMJL8W30hQXTnkP1xglz/MSMp6Cm1hvBGZ
X-Gm-Message-State: AOJu0YywxBIVl0HzhyhVvLdzUlBaYiejrlmi8+iQsaeXGMBJAk2h4QJV
	yWfZio8SkG2+6hfaCv6Gr1Tdde1797cM6keOUMN12PC+Z1NGfHflXuXKKuvExP4=
X-Google-Smtp-Source: AGHT+IENbxbCIveBfU+56Mh8grD6M5RzWxhN7Hek5IRjzUTl0X8SyhHShX4YeSl1RmBxMd1Vsijtiw==
X-Received: by 2002:a92:d3d1:0:b0:36c:5440:7454 with SMTP id e9e14a558f8ab-36cc1444bedmr308848125ab.1.1716307501743;
        Tue, 21 May 2024 09:05:01 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-36cb9d9c943sm64565475ab.49.2024.05.21.09.05.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 09:05:01 -0700 (PDT)
Message-ID: <110d2995-f473-4781-9412-30f7f96858dd@kernel.dk>
Date: Tue, 21 May 2024 10:04:59 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] netfs: Fix setting of BDP_ASYNC from iocb flags
To: David Howells <dhowells@redhat.com>
Cc: Steve French <stfrench@microsoft.com>, Jeff Layton <jlayton@kernel.org>,
 Enzo Matsumiya <ematsumiya@suse.de>, Matthew Wilcox <willy@infradead.org>,
 Christian Brauner <brauner@kernel.org>, netfs@lists.linux.dev,
 v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
 linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <2e73c659-06a3-426c-99c0-eff896eb2323@kernel.dk>
 <316306.1716306586@warthog.procyon.org.uk>
 <316428.1716306899@warthog.procyon.org.uk>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <316428.1716306899@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/21/24 9:54 AM, David Howells wrote:
> Jens Axboe <axboe@kernel.dk> wrote:
> 
>> However, I'll note that BDP_ASYNC is horribly named, it should be
>> BDP_NOWAIT instead. But that's a separate thing, fix looks correct
>> as-is.
> 
> I thought IOCB_NOWAIT was related to RWF_NOWAIT, but apparently not from the
> code.

It is, something submitted with RWF_NOWAIT should have IOCB_NOWAIT set.
But RWF_NOWAIT isn't the sole user of IOCB_NOWAIT, and no assumptions
should be made about whether something is sync or async based on whether
or not RWF_NOWAIT is set. Those aren't related other than _some_ proper
async IO will have IOCB_NOWAIT set, and others will not.

-- 
Jens Axboe



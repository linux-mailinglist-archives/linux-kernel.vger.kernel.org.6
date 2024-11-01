Return-Path: <linux-kernel+bounces-392387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A9E9B937F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 15:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A29B01C21381
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 14:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C1C1A76BC;
	Fri,  1 Nov 2024 14:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAbVCABe"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580D349620;
	Fri,  1 Nov 2024 14:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730472141; cv=none; b=Kxi67Lpcvxu0Oy8Wu2/V/GiWLI2KEHww2+36nkHwIGhwh9bvhQoyIwAi6BoWfSkNCbCrRqmldzoblMOY4BtsJlt69B5HDvr50hpOyk8VNS92Eh4RsxD8p+4sbHGsKEI/ubHi691VF2p94JjTBQq84xyUyG/NS3ruXTlEiXxxWJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730472141; c=relaxed/simple;
	bh=92BeyP9szRN14N3wpUCDFdAw3lp0H1Hv95G+mqqYqaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojRUj/58I/1Om7PuQLzIEQ6J0PnoTob0sdOPQqtaBDEA1oFaZoq0DWG/5ebsp/gozW5TYP+edxTXzW0nGj7w161ApqLn3g2k63LfVMx53LhiqwHpQsWurQmZckeFiTY1U8pxAx4vPOqGJwezkOq+zWU968cArWNXCwpMMKBF6Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAbVCABe; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20ce5e3b116so16981115ad.1;
        Fri, 01 Nov 2024 07:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730472137; x=1731076937; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tmGGUqAxRqXwlTKSg6HXoGDBCceWY6mb1JAL6Pmy3vU=;
        b=cAbVCABeMN3imhtUHM/3dbNhWJlctwcUz2HpKM4kpdPUnXLN3x2nOJOrzYCg1L0HnP
         kkP9MXRYIHvxMU5eeLeFt/LlhYFJwQcZQdOXnzRqwh650TivbG1hBVFpuP75MKUlzw7H
         aU8YJStV9Xssb+ehxnf67j2LcKu6/sFK1CYC0lAI+3W2oXZ64GgxEKUFNsFpFO6NSXqW
         9xcao6+c4insCcHbpNAd7bPQ0y1iMSoBR6Wan4HIqntnjhbo2n/AFL0DhtTpQOqQM/Hz
         zPU0b/brk3DPFyomBdBNMsq9osshLRLXZEI7/unp4MldHcePP327zuxPJsW+Ibo/cx5O
         XefA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730472137; x=1731076937;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tmGGUqAxRqXwlTKSg6HXoGDBCceWY6mb1JAL6Pmy3vU=;
        b=KXEANJI2JmdEnR8Rv/unFIrvW/z0YkQayb2WDLXCjn5ix17tAqgBQVxu840xgnXETM
         HDQn3gK1QwUg0hWmH9C453awTAI4bm6iezpg/mZmJQh/hcHUkibtA8JTkv/exaG6WAWz
         NT/HjSEChp2WxfhMjPmjHi+GZTRjZMw8vB49eeYx48dVSVBqdT2jAz0FBi7b7QnxxFyy
         cECHWnLLB55MhOoRTuV+HUrHqd0lePAHUKzTVdYZl6bQQh7G+YEn0M044V/7hE2KzSK8
         clFljM4qy1iuGkBhuaCEBu9E+T8m/4kfK4xeoxGH9uis3VPS31W8hLk4ul+4qSqZhkSw
         rh0w==
X-Forwarded-Encrypted: i=1; AJvYcCU+mBHSEoqhOn31R0Yw66FrcOfmv0p8+DDBY9Fsm2j6GGsUmQjny7TiGp2UNHgKG8vBfOep5kozZTEi/cc=@vger.kernel.org, AJvYcCUDWWYToQlzlPayOW4/kQ1BN5QD0Qu5apvqka93i4mfpAKSRB35dSq+H4RqEOhJ5VUBjzvS0fQ0P6HL@vger.kernel.org, AJvYcCV0J0D8OWR3zTs0ze8iwBKcA0droWW8wVO4hg03MMb2tMnFWyMc8TUichL/il0ElzhGBBQ+aGEeN7uDORmG@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv5aFkwD7y+rKeE5lM22BxxuvXDNBSLsUqeUl7iXng2eu/85KZ
	J2orS+mof4+acO0R+AacOztVdBXl9ai5qtFiDEjFXeB2TLhZUntI
X-Google-Smtp-Source: AGHT+IENuLZ97F2bqe7sJK5q+NTYtNe1xmrkuozpFQsm9HFqDqbxgnDPZGAl6IXcgt1vzUu5vsGJ1A==
X-Received: by 2002:a17:902:ccc9:b0:20b:8642:9863 with SMTP id d9443c01a7336-2111af3fbf0mr46632445ad.18.1730472137542;
        Fri, 01 Nov 2024 07:42:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057c083fsm22142835ad.187.2024.11.01.07.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 07:42:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 1 Nov 2024 07:42:16 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	jdelvare@suse.com, sylv@sylv.io, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: hwmon: pmbus: Add bindings for Vicor
 pli1209bc
Message-ID: <ff50f611-8d1a-4e17-a922-b6b2b1d94e42@roeck-us.net>
References: <20241021123044.3648960-1-naresh.solanki@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021123044.3648960-1-naresh.solanki@9elements.com>

On Mon, Oct 21, 2024 at 06:00:43PM +0530, Naresh Solanki wrote:
> Remove vicor,pli1209bc from trivial-devices as it requires additional
> properties and does not fit into the trivial devices category.
> 
> Add new bindings for Vicor pli1209bc, a Digital Supervisor with
> Isolation for use with BCM Bus Converter Modules.
> 
> VR rails are defined under regulator node as expected by pmbus driver.
> 
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied.

Thanks,
Guenter


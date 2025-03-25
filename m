Return-Path: <linux-kernel+bounces-576288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2912FA70D7C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 00:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B59A31715BA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 23:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF80A254AF7;
	Tue, 25 Mar 2025 23:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5fLFno4"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFD019B586
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 23:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742944269; cv=none; b=MG220iyfWhOSimkHnXD0O6QbYtBBwo+qWXidQhIvbzDdAAlKijHctjJAJm/yfELEczbi6XTngxwHdGUnzoRaPbLxN2KvkHbv2aSqT2iXT1MeMLfmHzsG2KUacnUSj1Mkr8Gn76DBxcMwim1U7IEOdjhJ3HHsiSt7efu0Vat7Ndg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742944269; c=relaxed/simple;
	bh=mBxwdIKcLzCbuwKXu2oo5JvPVZfbX1AHe0z3d5CiU5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FvduuNU6+ShsSU7tF2N6NdoDZTXXdt+U3yis0rZJllMecYsaaay/dYD8fnt9xER3I1SXYjfb1hjJS8jSJJ1ZIrACpFVqGOhBJrptJgxlKNdBqdouLgoYknw03uqGzQT230c71mcg3beOGl2LcnCTrG4GoEw5uOueT5XUIKfza2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5fLFno4; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-477296dce8dso40405611cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 16:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742944267; x=1743549067; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yv0k/Fr18Nia/oix5F2g4TGuH0nYdcUdhj7DYGGgxH0=;
        b=D5fLFno4slEoHKTRTWgW5v5JJBSpWKssRvyOwZGGPfm7/hGyQrv5S6GbP620ivP8+G
         znO3uDxNj+tkI256ZSE6042w093Bw+ZGUbp/aAbaB2NtVF8oIMcKhOwMHsWcs9cpcDC+
         B9vi2avPRIVsZHs8hPatNs1hXlAJ1O/B6/2FwTtiTtP64AKsnzCKxNvIkAQ8LI05SJrV
         t1XfgaRKYa8+e9MResoD03NTeHdIqyLISIQMfuiMLcDuBYlhwO90M5Y91jrQBg1RbvHc
         5ymQvJKLqN/byBlt/vCuzehpfiyXZhfaWFU3C85rBkPQyf87aZ/Vv/1Ff4Qj15hib9f4
         jy+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742944267; x=1743549067;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yv0k/Fr18Nia/oix5F2g4TGuH0nYdcUdhj7DYGGgxH0=;
        b=rXNqESU3J5rEX/aQUw98WRcMDyiy3pAZtHuDWN9dKQnDkPy7GYtUbpNPzLuFWhwxTK
         Qilssokx5bnN7qB8cJbHIYYPq5avouoOVdFJbHHoFm9Dqb1DofFr4v6ZyH+CZM9Qqh+F
         R6mtRAyaJaOqW7ZCII1YonKiIx6C0YDWpz9K/lZkMXR7WeRac09xrPjdskzGm17NeZtv
         HkKuZyLg666dKiiebbf099hu+l4UfwN4S8Gvh6+vytCvnk6skDK0pyyBYZq1Qj1aUWFp
         VbtsVBe3dNUSH5kjy04Ms/n/XiFGXcJm4sYCnDDx+qcb3r57lrEjTVqn/Bob5nVJ5Ggp
         GUMA==
X-Forwarded-Encrypted: i=1; AJvYcCWveREBJT3da4lPDPStWt5nxqoL5/qGGWphbIZLLehKZNfUBYsgb7ssv9M27KVi+m0DYlt/LiczGcfrLn4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp4+Ag2yDDr+wJ+aAhrLaiUcluvXlpUUSQBl0MDUyTo6J+3KZB
	9hUv1tSXGPVQ9TFCF3HkTSzy9k7xLWT1Y1JTaZKEbrklEbL7hHHS
X-Gm-Gg: ASbGncue0egLqr1zKY0Zk3L/YVG0uRopYMGULQk+bR1zIpbmVagn7F6Xdr7s9Uds22l
	XKjB7Ec3cKopZ9zXi8eZsQzK0hwe2opPX7BVpXlENQS89ksJpP6X8SKKg6G3N/WtZrzfKhoxvYs
	rIUzRhD2451hVcHsveECpOXc0Vw7F6F6rU+qNNNeuN6ew/7AMsRlVz5fIiVVZ8xpcpdX98goyd8
	zAUS2xT2mpW3CGWZo47qHVWNN/v0Bhxj95t3oV2oZ/lRgKaDY7Lcx4NO7zyB/k5iuoGHrUJ5ilz
	EYwQVjbyH4y4kQElzR7JqufnBLmqzgzc4wpHk+j8v02QdLQp2+i0dmEeswYP0AkywGd4X9ZJv3M
	7DED9FlE=
X-Google-Smtp-Source: AGHT+IGA1CQFyXf66Rv0kFbgimISyo1ehln5yP3lhLZfPtIRMhjU5sUpgBnPf47YACkVrM56gugfwg==
X-Received: by 2002:a05:622a:4d0f:b0:476:add4:d2b8 with SMTP id d75a77b69052e-4771de4953fmr270018191cf.32.1742944266602;
        Tue, 25 Mar 2025 16:11:06 -0700 (PDT)
Received: from [10.69.1.11] (c-68-55-107-1.hsd1.mi.comcast.net. [68.55.107.1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d15a2d9sm64447471cf.2.2025.03.25.16.11.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 16:11:06 -0700 (PDT)
Message-ID: <9ab05b38-6f77-4b0b-8a1b-8314e2873047@gmail.com>
Date: Tue, 25 Mar 2025 19:11:05 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: use static ids for ACP platform devs
To: Alex Deucher <alexdeucher@gmail.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 sunil.khatri@amd.com, boyuan.zhang@amd.com
References: <20250325210517.2097188-1-bradynorander@gmail.com>
 <CADnq5_MNBUY=jWbnq-gZQ_4_M_sBJGAgMD0bj2cMdnkoU9G=HA@mail.gmail.com>
Content-Language: en-US
From: Brady Norander <bradynorander@gmail.com>
In-Reply-To: <CADnq5_MNBUY=jWbnq-gZQ_4_M_sBJGAgMD0bj2cMdnkoU9G=HA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/25/25 6:12 PM, Alex Deucher wrote:
> 
> While you are at it, can you take a look at
> drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c and
> drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c as well?
> 
> Alex

I think it makes more sense to handle that in a separate patch as it is 
an unrelated ip block.



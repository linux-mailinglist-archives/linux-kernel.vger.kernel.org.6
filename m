Return-Path: <linux-kernel+bounces-369450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6A09A1D74
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 10:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB3411C23F90
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726B81D5ABD;
	Thu, 17 Oct 2024 08:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KT8YBcyd"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892251C232B
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 08:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729154594; cv=none; b=swQaKSEOSoskuZ8BMDzLsjfClXjyaK94vXYZyQJ/WeSDXPL+/8d5iQ77lBlzai+Gump7TORZJ3eXMreVxmBNG/5+tGMq3aXQiwSajOE78AFQ21FJY1cTSRgqe8bph9vZDGMvT5pZzDjnOC5jNtp3+NCUEbZgJD+p3V+AGeBTh68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729154594; c=relaxed/simple;
	bh=xbkNK59K3kQpdDXqiDhpWqCXaS93vbxGn76+AvW6fIQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=Wxb4bjr7OaDZBlH5ly/cccB7wI0Uqbxedhl1ip8zwyzQIGUDgWfTYyJvD3hmnDbtsdc/fPVo9oZ9qUi3MroUNhIx5oxBpVvnUgK7JQfGPwzXtl+cw2pL0ykGOOEeNxogoBCaEagdXEQqjdGkx5wENAvRocxAa3LXQEUViKpSTNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KT8YBcyd; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e3fca72a41so33546a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 01:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729154593; x=1729759393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQAB3nnQ+Mdlc/tt0eBAd1ec+dzX44ggYry/kZq7/hI=;
        b=KT8YBcydjF3sXZcOQ/2r+xoP/SR2oGoDvIa9OZnPey1vFQhS4tChy3wec8yQ6sBc2s
         FXCV5dBPGjKvFR6G+58O4fC3tbwZRABWBnYnTXbizBf93fS+t/usg/qOyVc+cilL6rb9
         rLGA73geXsJUGrTe15+L1MQRtBPXdRJIjElMLDzkXFK8FjjZU9AOVAmQOGXVZPCkrpGU
         AukX+NwmCl7dhC7Ei0vieCdhHmKlOElT3YvcfbEPPZAjJ180qOaldH2uUhrlZ1hfuhW9
         UMwIQ3OMh8MYvMh9OcgWyx6kNfDzcyaPNMm3wh65lgp94IwRPbg76apdnB+vhuDoIkAz
         uldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729154593; x=1729759393;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yQAB3nnQ+Mdlc/tt0eBAd1ec+dzX44ggYry/kZq7/hI=;
        b=sYzVYJrMhc1kK+PFFN4g/c8ENG/abZv3k4E5cAl7s0Ix7LklnwKB+llieWHVmeedpC
         54djgJwLXiZ68OnP1O0VDLq3nnf6UkZeC2ZK5w+c8YJlB1CirArpLyfWeCDJg8fj4MFg
         KMi+Mgob9nznwfWHqW2vFKm53B3y8aUbsF6GHkojRggzv4eXRegb+PXkFn1u9dPFsQnt
         33ve2UfWacWYcX/xtjBbQNAblnOiJh0atFdKXoanIZghtiixLgdLLdPiTWd9/Hy3bfyA
         9u5Hs9Wn7id7EFHrz8uSJVHYVJGnBjS8LEVMZUbee8GSXaioY8hq52mDYoFnoWCAVUxf
         lTgw==
X-Forwarded-Encrypted: i=1; AJvYcCVni1Y4QwpY/g+dEpoOsBg5nyuyBl1qG0POLS6btTAZB2BgSb1a5o7riiQgcAe86jX8eRK2CWhHBMpmuEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd7e1EClFn7Jznh0GPTHkxKntbV6aaWDK5hxgvTSmOukyFjEEQ
	GUiI7I4Pv2dlqec+NsL53TzTBm5TOv8KhI6wDXZ5DUSMTVkwRJlA
X-Google-Smtp-Source: AGHT+IGyP031j7KiczoaeT0zkXTCu6uPPcWuYBfUrEHy6wZ3NZAs2wt8XjaAOno4+gv2ZLCwzZsYcA==
X-Received: by 2002:a17:90a:d808:b0:2e2:d74f:65b5 with SMTP id 98e67ed59e1d1-2e2f0ad1729mr23181386a91.16.1729154592825;
        Thu, 17 Oct 2024 01:43:12 -0700 (PDT)
Received: from [192.168.1.101] (14-202-215-216.tpgi.com.au. [14.202.215.216])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e3e090756bsm1280567a91.50.2024.10.17.01.43.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 01:43:12 -0700 (PDT)
Message-ID: <65fe0dd4-e7bb-40d1-9b89-7b330984268a@gmail.com>
Date: Thu, 17 Oct 2024 16:43:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Tuo Li <islituo@gmail.com>
Subject: [BUG] drm/amd/display: possible null-pointer dereference or redundant
 null check in amdgpu_dm.c
To: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, alex.hung@amd.com,
 hamza.mahfooz@amd.com, Roman.Li@amd.com, chiahsuan.chung@amd.com,
 aurabindo.pillai@amd.com, Wayne.Lin@amd.com, hersenxs.wu@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

Our static analysis tool has identified a potential null-pointer dereference or
redundant null check related to the wait-completion synchronization mechanism in
amdgpu_dm.c in Linux 6.11.

Consider the following execution scenario:

  dmub_aux_setconfig_callback()      //731
    if (adev->dm.dmub_notify)        //734
    complete(&adev->dm.dmub_aux_transfer_done);  //737

The variable adev->dm.dmub_notify is checked by an if statement at Line 734,
which indicates that adev->dm.dmub_notify can NULL. Then, complete() is called
at Line 737 which wakes up the wait_for_completion().

Consider the wait_for_completion()

  amdgpu_dm_process_dmub_aux_transfer_sync()    //12271
    p_notify = adev->dm.dmub_notify;            //12278
    wait_for_completion_timeout(&adev->dm.dmub_aux_transfer_done, ...); // 12287
    if (p_notify->result != AUX_RET_SUCCESS)    //12293

The value of adev->dm.dmub_notify is assigned to p_notify at Line 12278. If
adev->dm.dmub_notify at Line 734 is checked to be NULL, the value p_notify after
the wait_for_completion_timeout() at Line 12278 can also be NULL. However, it is
dereferenced at Line 12293 without rechecking, causing a possible null dereference.

In fact, dmub_aux_setconfig_callback() is registered only if
adev->dm.dmub_notify is checked to be not NULL:

  adev->dm.dmub_notify = kzalloc(...);    //2006
  if (!adev->dm.dmub_notify) {            //2007
    ......
    goto error;                           //2009
  }                                       //2010
  ......
  register_dmub_notify_callback(..., dmub_aux_setconfig_callback, ...)  //2019

I am not sure if adev->dm.dmub_notify is assigned with NULL elsewhere. If not,
the if check at Line 734 can be redundant.
Any feedback would be appreciated, thanks!

Sincerely,
Tuo Li




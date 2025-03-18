Return-Path: <linux-kernel+bounces-566808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E14A0A67CCF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 20:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC7184258E1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 19:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26159213E6A;
	Tue, 18 Mar 2025 19:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JgHFN4NM"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E368B2135AC
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 19:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742324848; cv=none; b=CPJBtcSnq4d2CXPHSkMO3+7ykBMqKKVTwGoYw4522jEw6jy7CFaPSqcim8/+oc68kx4OkQ1ZuRZtnfT04dWSF1BRUokgBQpWBVSTb9laav9RLOBTzxQ+z5K+9IBg4OWhzwwIHC/2X84py03jO3dWC3KoAM1LbpTwun20A6PQ8BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742324848; c=relaxed/simple;
	bh=7u+IjDwO6+F7DI7uchGCYv5muBEp0ShcxZa0CbC1aiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QP4I2w9j2a95DvsmCYVg+1VtB8dzDF1VxH8EkP1z603Rbw1OXjsnbHQX2jk1FksxM93x7gn5pZsei0IfueGLep3/WwWIVZMao0czipqW1vm3j/LVUGCNpJCZ8xgN+stVtAzzAn7T+63w++JttbdwnkiNa0XIkvsKZkPG0cVQ5zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JgHFN4NM; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-85b41281b50so154624739f.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 12:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742324845; x=1742929645; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ot+UoxjARjoK5fUaxnFU+2GwMHtgeInG0/YoXF7TxQ8=;
        b=JgHFN4NMWbWTBPaq/xQ3y7xFhapzXnMvVykqlYUtRhe6bilU5aYcvQHtUcuxhld408
         Qb+GR5Ak7GVKGr4+lcGkwPk9jqx7lWB5epNzS+TM1L7BC3rRhgmWZ9MjpToTBP7c2nBs
         iGedFrDxi2uxH4es8LsXaz2TdUTp6/4mvt0seJ5CicwfM+AMS9QyPACwqZhPMK0QNFsB
         hC7zvrqxhk62G6Y4xuucP90tjCeXD9lXnOYtthDwpISF4d/qyQzKCU5RFxqHUYjry/ut
         H105geSNRYzE5Ri3KaRPtHtMjinMwg4Jlg44bBzp7NvRRVyp5BCXo/CUPn4HqeIoWsgP
         e94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742324845; x=1742929645;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ot+UoxjARjoK5fUaxnFU+2GwMHtgeInG0/YoXF7TxQ8=;
        b=Cb2zjX4vPdbMiWGIQih7BtKESVJKUF7jrSBmrmpwVVAScZM6U6yn7sWQ0wS8ROjJoc
         xj9nEAQ+pE6+cphckXlfGlK6PybS42jS/XJ071aDksI7frAI73y76bcwbVFEup1n9A83
         OwOpgko+x5FCEstIzpkEAV7+jx5Qf/tG9fQ/H/7Lrq0SOnzCBQYjAWSTm43g4Djcy0RJ
         1awGNd/GjHgYxndO0ZKxmWu2Tt6h8J/PpGwrhLxEVMMO+3dUQc5D/iA+nNoMDL0wyb2L
         XrW6coVx5huKv8+pXyosGaWn8knGdHOuFyO+RTu1AXZ52+CD2k5i1GZXuNif9chT4qfU
         //uQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4tb8EDwkHgL64+2RLx3XA+uRB36P4wFuQqgSYyhSHEZmwr18QBN+3144P9knSrikCnAfcce0OOvPjbfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW2rfE14HRIfvwq9oc54u4x3wucSzpooyxxTix8SjM3AYirgAH
	s7WUNeGez3o8vVRsUsP89oyuCsKZ+sB1SLX67WwfukUbMyaAaQEiG4fulPXQJbU=
X-Gm-Gg: ASbGncsPFHpWMeKn1APV7/JelLM/6V0eReiS63Bh/tMDxQGoRFHIKJKCgg/BcG3YwBs
	ICvGDMIz41GdA0r/ZntI2GXJQuBz71k1SICqH07d6OUQpD+YmxlXpY5Lu/yPvkJOqzjcEXtyB3d
	1HS0SjqOB5or1/YXtJsmHUTF49mt2zEVgB9VTtb0EjwBOJsiwwUDq+AzPM138qQNKGxT5/MMUqH
	DX8/e8vz8RSlLTyZPLzvL4dqPlgotnwvwj8xXYALNBFqdvjaimkpCUyustfrZScXh8ErD+w3u7L
	C6Wou4nozcQUp4kOy/tWaAcURdaeWlhtqQ4aaRxAGA==
X-Google-Smtp-Source: AGHT+IHcMcUmgc/6cRGq9lqUuozc5Gqv1nKlNJjLpTLDgmmpVYYIwNfBe3wFAK/zGFyhAHDHTYXkng==
X-Received: by 2002:a05:6602:7518:b0:85b:3791:b2ed with SMTP id ca18e2360f4ac-85e137e1516mr12150539f.8.1742324844949;
        Tue, 18 Mar 2025 12:07:24 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85db8777e2asm271770039f.11.2025.03.18.12.07.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 12:07:24 -0700 (PDT)
Message-ID: <01298280-c58c-4cb7-846c-b456132c9eda@kernel.dk>
Date: Tue, 18 Mar 2025 13:07:23 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] possible deadlock in io_uring_mmap
To: syzbot <syzbot+96c4c7891428e8c9ac1a@syzkaller.appspotmail.com>,
 asml.silence@gmail.com, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <67d0bee4.050a0220.14e108.001f.GAE@google.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <67d0bee4.050a0220.14e108.001f.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz invalid

-- 
Jens Axboe



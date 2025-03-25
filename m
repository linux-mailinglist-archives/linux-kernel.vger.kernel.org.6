Return-Path: <linux-kernel+bounces-576276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DD0A70D42
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 23:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE1D2175FB1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 22:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528D726A089;
	Tue, 25 Mar 2025 22:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oxNtYwXE"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706261991D2
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 22:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742943074; cv=none; b=edlGhSC9TD8+R8e8691sg/rjO8kXbbmMMNSx7haV14xn1ClkR1HHM/8MimWDtSXrhfvKINWFwtBGO9BD/PSAtb4Lo6/Yuf7Y1PjL9/XNRJE6M66EEwDYa2Fw8NzECTbxO6tfyNntumaaM8i4QRIzAUaioltqC0gbbd/6zPd5Q6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742943074; c=relaxed/simple;
	bh=CCGz3+zobApzQyVtTVLrH+hh+bHEa7iMAWzGZnuESp4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=r8aL1qjfuz8wONK/I725qm4G44jf0tBjpzphINqnWy5RA+YfXKeHjrJZr6NnWcJ2+nbV2OsHxDeDFSwYTVSdHW+GpnQrkXVB7zHj7/0m/drjZCIlllUl2o6UYpypIKn+wImLz1LBVJydy676C2i+pqFuWNZ/Xft0yk0vfTE5YqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oxNtYwXE; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff798e8c90so9651395a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742943073; x=1743547873; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CCGz3+zobApzQyVtTVLrH+hh+bHEa7iMAWzGZnuESp4=;
        b=oxNtYwXEHYzK9cdztDUCt4oWWkBhIL2LYxKWwzwx+GQJ/ToyJNZH6QWc7LTwQmHQLE
         hOEdXZnejHDDTQ8twECsuRiRVcRvsJCrJ27ZlY8Rx224HkTNcQQdhgqpuu8pdZQfMy1h
         g6hECwq8a26ieCbw5q3Yx5kyrDeziQ9T727D04sqMzJHEytWofNOBm5zxpKGgCWh1hM0
         WDqckXWQO3xYyJ8itEPsYEGIU+G6/HxrS7bS8rb5x1EBBvhH+dBZKW90otGT0ii+6zQd
         vBwwo/RPYkxVMDVKheoZHwKa3zIXBdftREiTDooba+5oI0VQfnqnRZvNTq9rttQBFBK8
         X0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742943073; x=1743547873;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CCGz3+zobApzQyVtTVLrH+hh+bHEa7iMAWzGZnuESp4=;
        b=tZVzGeZSYZxmAnkZAgvQn97Lekxnc2rb7yqhKBiv2Gh+KpEJ4T3k7uflT6N5kLNu8v
         HKogmEM3J/Qst/q+qNj561hw/fqXmnkgdlolixyy7pDL2I831XYlckZeqVlIIyfDVxq1
         T/QJ9NBdvCXM6kvNqMvRyy/tX41mfqyF6OK7W1N64dLjBqKxHgJOdpRY05O5LqabKko0
         xqlZJPN5cQqahL2MZb8zyT6PVRBVxL+J0s+SZzHktzuOMbk7xWPyAIwbQ71rTjzwuzlC
         /w/3mpvLu9Ks09eCbD0DHvkpwqIym3GijvjSS/YceWeoHmvf8ARclg0oA/PtSlj77XCX
         11ig==
X-Forwarded-Encrypted: i=1; AJvYcCWcv9J+urb5gNBofR6VMKtxxh4TnGJmmKT2vEIAI6ShZyuILigtgG1z1LFJFyxoAYHQKmQitfR+dU2W7eM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCKN3ZVHAwwTonjj7VNcdJ47HK5BsYL/8Pcfvru60CHW9SqC+m
	UHk2ATLt+amLGbSxsU1i93lpnZfc1sSE14KbWXL/lqi0GZkBgwcKae6IL4ith04FvF8MBs2iDQ/
	mOg==
X-Google-Smtp-Source: AGHT+IHYTk5HZTr91hcf06j9nnJIfVo6oiWibftCNtH/6yykV0si7/iIGPC1/rRmh15JykuM0xe0O65nx6s=
X-Received: from pghd10.prod.google.com ([2002:a63:fd0a:0:b0:aef:56d4:b718])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4c85:b0:1f5:9069:e563
 with SMTP id adf61e73a8af0-1fe42f55966mr33188525637.21.1742943072674; Tue, 25
 Mar 2025 15:51:12 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 25 Mar 2025 15:51:10 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250325225110.187914-1-seanjc@google.com>
Subject: [ANNOUNCE] PUCK Agenda - 2025.03.26 - CANCELED
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reminder that PUCK is canceled again this week.


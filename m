Return-Path: <linux-kernel+bounces-337278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB359984805
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 848C81F218D3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBC81AAE1A;
	Tue, 24 Sep 2024 14:51:46 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE621A7AD6
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 14:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727189506; cv=none; b=I1dah+2BMIp+fwWuWmEIgAmzn0Fek8vnjoIkj7vYaig60FDCDH6bYoFl724lnntr3xY+Z3MPvm52y9Sy4C2vvhMflfqIw45qWYp+jv7dVW+bzBuwRDh3mdGGHriKuZV3gtcS/ZhIC0/ajtZ86CtNx3wCx5wJVRmjGcT4/6Qnq5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727189506; c=relaxed/simple;
	bh=s1601j0+Oxhrj04QYmpMQk/0cqhNQZ09t6PsGYwneis=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dviNjAmfA9FC4nQeb/dMUIAHiK63O+RIO/oaUWL4KLrpoFf/7hXlrzOkk2/+Ouibcfc9+pPehj+a2FX/kiHDUaF/70Lshhtxtg26JbTHXx+IEh766eg4sx6WZV7w2RPTiu8Fhhx9LSmb9bBx4AAC2O1E/rYYc2WqNP0VEXiakeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a1e69f6f51so3340315ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 07:51:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727189504; x=1727794304;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s1601j0+Oxhrj04QYmpMQk/0cqhNQZ09t6PsGYwneis=;
        b=ior7jCjZGetCfn63DaviBCihnwrSCURRWhH1tVUDg9l7RxFlPyBymah/S0OjKEiCKt
         Wej/d30srHzRLsvsK9cp7s6sxtWdupi1ANKh7VgNEJdCdDY/g3XRZRWDQRhgs92v+yZA
         wKqME8+4OKGVJtzXQ4cKk/mUwRTBQvPX8bNyJTDcW7zhjPY10tunfoTSUwPhcjCvSlVq
         nGldFxXEfK/qz3U/8zGbO2nv80Afc1BL0p0987w2pW9O1W6fubEMnMCP5gQZV1elhLTV
         kQNcgIPjNMX1bdoBfAIcfQ4DckNXdDOOXb1WeCErxwBNBXTimdhnVhIAzgb8cnQyQQaY
         QzhA==
X-Gm-Message-State: AOJu0Yzz+4Qe8XGXqQdmw9yfVdDtnIC19fiTbjnNmbEFmjnppeWcmree
	VGA77P45wTqSvQyxkLFVfrtqsOaQrt0ztTHC3f5G69DW5dMoIEUT6D1NdGNtl63b1w/DbvWW7ee
	eWGh2KrObHe7vpu0eKlq0M5GtNDYkMFTr3DxNFr9v85anKD6ljkxLQzQ=
X-Google-Smtp-Source: AGHT+IFTvlQzlbYcybhnTynj9NdJDxZinRpmOj+UA2mLkk8HoUX5PUZd/LnungqczVTKHukIDaaCa569JeZRc+A2fPnB6GB+mEJi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18c9:b0:3a0:8c5f:90d8 with SMTP id
 e9e14a558f8ab-3a0c8c7eabdmr118498095ab.6.1727189503819; Tue, 24 Sep 2024
 07:51:43 -0700 (PDT)
Date: Tue, 24 Sep 2024 07:51:43 -0700
In-Reply-To: <000000000000f9e854062251d673@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f2d1ff.050a0220.3eed3.002f.GAE@google.com>
Subject: Re: [syzbot] KMSAN: uninit-value in udf_get_fileshortad
From: syzbot <syzbot+8901c4560b7ab5c2f9df@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KMSAN: uninit-value in udf_get_fileshortad
Author: gianf.trad@gmail.com

#syz test


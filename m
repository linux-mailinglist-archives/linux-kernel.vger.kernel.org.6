Return-Path: <linux-kernel+bounces-333078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 219ED97C32F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 05:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18F7F1C21737
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 03:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCBD14277;
	Thu, 19 Sep 2024 03:38:48 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4F9FC0E
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 03:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726717127; cv=none; b=MtanR3M1MSzJ0n1luzwMRHNgW8IFxUx0UxCDjS0T1ER6hyHh4DNQrhPSfaAaJGz3RbssyMez9zdmqs5jcoT2eWwQbEwEVzEn78w6gCIECrqtnPRXFFrDIoKs0eP7qt+xuKXnswHdjZFw/6wTKt5S0BosnUYgT1IXDv9BCsqHVuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726717127; c=relaxed/simple;
	bh=CKWziA7ytvEiqaIQ5Nx0XwRh5m3vdXkhAjrmCtUYQDE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nyhkLjv1YD4p2T54JqQzojcEh6RRzKHiz5eMDGTbe0wgojxvoPqt2Kq/Tmx5Uw2mRvtaAQp7lIAcXlmN8xgma9ftBXd3O1gEMcTsBJyi2cXrsjGRb+oicK8QMbNFRDmBe4FkpSX9RbMilTr8d+vAHu5FwV0X84gbvihnAcIHUSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a099015de4so4726375ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 20:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726717125; x=1727321925;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CKWziA7ytvEiqaIQ5Nx0XwRh5m3vdXkhAjrmCtUYQDE=;
        b=npD5Th+X5JCfvrgwuccqe6Qtk5HCrHzhlLd3pDQ3Gvi8CDzpFpCl8CqE64iCLWyAaJ
         nYIZU6PsPGsT/Tb6R7AlE70nJSFOwkdJOweQwq1yao8eCCei4qUHXJmmPOeaQNPoCWuc
         NmCTmq7hVgcmDZV7bnokmwX05STUKanyiSINGNxVMP4MfJshKPAXwHKveMU+1ySAv30X
         p/eQ8Kar+96GezvVjFV8Hr/ggeI8WnP5Bp9v20j4wyB5XhXRcbvoVa34fcgx52CvuIWi
         /h7x6hb0K1rdPxpywotTMtS0ZLykm7bkkL8zwq1JuF4yEbIes6H81QVrw7H+GBvW6iO4
         qG7w==
X-Gm-Message-State: AOJu0Yy13FZkhrLQFcepU/xOjkzVkPlbbx9hx/3VITIcAUSxQXfJUznq
	LJfTNfApuYQAR1pjDnfNgcmmbpc65BTqG3SfBss7aEzwhgJlsTkWg2v3a5ZoO/GX2qNB4AorIJZ
	/upw8d5ScNz+cRvsQBQMaRLcjy4NvQEum7SWUE7vGLZC7gwHGdRP1mkU=
X-Google-Smtp-Source: AGHT+IFi/9GEctKi5zQyvXfpxmRdpbhq+igCK4lYclZnNWhsLVWGOfCQlPUvyLe8JMpI4R9CwZMdQcm5zrtQxilOLIRk5yJuvbYZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c8c:b0:39f:507a:6170 with SMTP id
 e9e14a558f8ab-3a0bef63a7emr17577315ab.8.1726717125653; Wed, 18 Sep 2024
 20:38:45 -0700 (PDT)
Date: Wed, 18 Sep 2024 20:38:45 -0700
In-Reply-To: <00000000000014ea2d062253601e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66eb9cc5.050a0220.92ef1.000e.GAE@google.com>
Subject: Re: [syzbot] WARNING: suspicious RCU usage in bch2_snapshot_tree_oldest_subvol
From: syzbot <syzbot+f7c41a878676b72c16a6@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: WARNING: suspicious RCU usage in bch2_snapshot_tree_oldest_subvol
Author: bottaawesome633@gmail.com

#syz test


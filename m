Return-Path: <linux-kernel+bounces-407384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B50B89C6CBD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7552728C45B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213F21FBC89;
	Wed, 13 Nov 2024 10:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFA99/JD"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4268E189916;
	Wed, 13 Nov 2024 10:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731493271; cv=none; b=iNEICOjv5whFYwBqtGdqa65HV31pz+jKLKgDI3W15/a3DTZ39WDGSE+m0At0fKesP3IyYcT7jLi9N2O6dBMntVHCXDSkDG+nKea1vDpX1R1LX3LYnlOEO7QMyBNxaE0Rax4zFmL2xINDyL5FU9TAfpXEO8N6z0A0lT6aYOHPz9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731493271; c=relaxed/simple;
	bh=LOJ9xs7Ri8lQ5uZ3OJsVm7wJQnBoIBZsM0Wi+OQMe2s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=HvDFUwnioKho0gjW8m7w83Olx1AgqKqeGGJmrVmV9dxlQpbYTg8rYV4ymKeahoh6gOBuA8EyBkwl4NPqNlg4eXOEFHowcMxWCE+v+yJVLIYA1+Kx8ARfMFGByMzAVe4haVU1WAaU8TGMWZg0ZnlcnjQueY/KRc7mztGE9r+V6cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFA99/JD; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43155abaf0bso59819885e9.0;
        Wed, 13 Nov 2024 02:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731493267; x=1732098067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OZGbES88r5DABSxpQJZT2i6/Gmn59ECU1HvoAs0un0Q=;
        b=HFA99/JDgryPLveW+GDq0t+4Ix7OZ3YlWAe1Ljh+LnYerkO4nsTr4eqlX4ZURog+Zp
         n2Xn5EFKRLIewkAgdWQLRcyciM7H/+n1dlbvxRalqS8VfQJC6PozxJH19/5BzB68Jr0O
         OFvuJkgYrLXqgxNuVtYJh6t+Du4sO3pKBnZZy7OsrpElbGvELrWl2i6HdILuJ5+wCg6t
         2ffGIYM7x1kvyocYQSa15xNTdEehU7Dx3xzf9tI+wl9xZGV19rAimpDl2DlRWOmeZ6Dv
         PwHoNz9i6wE7iiD5s098/Yd87IfsZwvL4F2b6KXDpUOoDd3eruNW0tajbZrL5plGgjiy
         ecxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731493267; x=1732098067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OZGbES88r5DABSxpQJZT2i6/Gmn59ECU1HvoAs0un0Q=;
        b=vwGIBohSZlDB9S1wDnE+9urxlLGbeYrtdbYmnCS8oozv9CHeK/eEBUCXcs49c451Mr
         +Jb3j7k9RTj/NNfxjzGqGWHR/m160nNB/WAvT1O0p7AmBM6SpPgA6JahjT+9ELujclzb
         EzFB5/FZuKqiucQ/w9gFtoTTucwLKVMzqoNjRlPrKyWMdL+lkWY4Z51LltVWCmr+1i95
         U7JmTXA9xsRxInVFhnDWdBzAlVdbnYMaI2pFa66ZE2BktN13MPbUMRse27KrUaoXeLAO
         17KdFR73TxQWfc9NKHzCwPmIixQjzQf/xCu9YynRF94zprNk1tEyo6M6hB7lPbGzy+zb
         E6Ig==
X-Forwarded-Encrypted: i=1; AJvYcCWXqIsYJmvh6II5wT60/OfwUTP3Udmxvsf7hKMMqdd9bY93RdqAX0l23K0XN/aCK32UrG1PaLH4Og8LaWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLs10oWRSpKWovZ3B3wmttCJ8e6VQcark2vWIm7+3wFjyhmKmu
	pmCg7AgbNA/k8D32NG4JiuDqezMPTNUK+n+1F4IrZDuCxC1tSNfM
X-Google-Smtp-Source: AGHT+IFqpqxvBG2aBr4Y/DRUhGIfda8OClFSV/TWPjW4Gj55CB+gbdN7/pZaoKLUK+/moHWaGGT6ug==
X-Received: by 2002:a05:600c:1c98:b0:426:6edf:6597 with SMTP id 5b1f17b1804b1-432b750a358mr174969985e9.19.1731493267326;
        Wed, 13 Nov 2024 02:21:07 -0800 (PST)
Received: from localhost ([194.120.133.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d48a7cf1sm20239495e9.1.2024.11.13.02.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 02:21:06 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/spelling.txt: add more spellings to spelling.txt
Date: Wed, 13 Nov 2024 10:21:06 +0000
Message-Id: <20241113102106.1163050-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Add some of the more common spelling mistakes and typos that I've found
while fixing up spelling mistakes in the kernel over the past year.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 scripts/spelling.txt | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index 05bd9ca1fbfa..2decc50f5a6e 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -222,6 +222,7 @@ autonymous||autonomous
 auxillary||auxiliary
 auxilliary||auxiliary
 avaiable||available
+avaialable||available
 avaible||available
 availabe||available
 availabled||available
@@ -267,6 +268,7 @@ broadcase||broadcast
 broadcat||broadcast
 bufer||buffer
 bufferred||buffered
+bufferur||buffer
 bufufer||buffer
 cacluated||calculated
 caculate||calculate
@@ -405,6 +407,7 @@ configutation||configuration
 congiuration||configuration
 conider||consider
 conjuction||conjunction
+connction||connection
 connecetd||connected
 connectinos||connections
 connetor||connector
@@ -413,6 +416,7 @@ connnections||connections
 consistancy||consistency
 consistant||consistent
 consits||consists
+constructred||constructed
 containes||contains
 containts||contains
 contaisn||contains
@@ -450,6 +454,7 @@ creationg||creating
 cryptocraphic||cryptographic
 cummulative||cumulative
 cunter||counter
+curent||current
 curently||currently
 cylic||cyclic
 dafault||default
@@ -461,6 +466,7 @@ decendant||descendant
 decendants||descendants
 decompres||decompress
 decsribed||described
+decrese||decrease
 decription||description
 detault||default
 dectected||detected
@@ -485,6 +491,7 @@ delare||declare
 delares||declares
 delaring||declaring
 delemiter||delimiter
+deley||delay
 delibrately||deliberately
 delievered||delivered
 demodualtor||demodulator
@@ -551,6 +558,7 @@ disgest||digest
 disired||desired
 dispalying||displaying
 dissable||disable
+dissapeared||disappeared
 diplay||display
 directon||direction
 direcly||directly
@@ -606,6 +614,7 @@ eigth||eight
 elementry||elementary
 eletronic||electronic
 embeded||embedded
+emtpy||empty
 enabledi||enabled
 enbale||enable
 enble||enable
@@ -723,10 +732,12 @@ followign||following
 followings||following
 follwing||following
 fonud||found
+forcebly||forcibly
 forseeable||foreseeable
 forse||force
 fortan||fortran
 forwardig||forwarding
+forwared||forwarded
 frambuffer||framebuffer
 framming||framing
 framwork||framework
@@ -767,6 +778,7 @@ grahpical||graphical
 granularty||granularity
 grapic||graphic
 grranted||granted
+grups||groups
 guage||gauge
 guarenteed||guaranteed
 guarentee||guarantee
@@ -780,6 +792,7 @@ hardare||hardware
 harware||hardware
 hardward||hardware
 havind||having
+heigth||height
 heirarchically||hierarchically
 heirarchy||hierarchy
 heirachy||hierarchy
@@ -788,9 +801,11 @@ hearbeat||heartbeat
 heterogenous||heterogeneous
 hexdecimal||hexadecimal
 hybernate||hibernate
+hiearchy||hierarchy
 hierachy||hierarchy
 hierarchie||hierarchy
 homogenous||homogeneous
+horizental||horizontal
 howver||however
 hsould||should
 hypervior||hypervisor
@@ -842,6 +857,7 @@ independed||independent
 indiate||indicate
 indicat||indicate
 inexpect||inexpected
+infalte||inflate
 inferface||interface
 infinit||infinite
 infomation||information
@@ -861,6 +877,7 @@ initators||initiators
 initialiazation||initialization
 initializationg||initialization
 initializiation||initialization
+initializtion||initialization
 initialze||initialize
 initialzed||initialized
 initialzing||initializing
@@ -877,6 +894,7 @@ instanciate||instantiate
 instanciated||instantiated
 instuments||instruments
 insufficent||insufficient
+intead||instead
 inteface||interface
 integreated||integrated
 integrety||integrity
@@ -1081,6 +1099,7 @@ notications||notifications
 notifcations||notifications
 notifed||notified
 notity||notify
+notfify||notify
 nubmer||number
 numebr||number
 numer||number
@@ -1122,6 +1141,7 @@ orientatied||orientated
 orientied||oriented
 orignal||original
 originial||original
+orphanded||orphaned
 otherise||otherwise
 ouput||output
 oustanding||outstanding
@@ -1184,9 +1204,11 @@ peroid||period
 persistance||persistence
 persistant||persistent
 phoneticly||phonetically
+pipline||pipeline
 plaform||platform
 plalform||platform
 platfoem||platform
+platfomr||platform
 platfrom||platform
 plattform||platform
 pleaes||please
@@ -1211,6 +1233,7 @@ preceeding||preceding
 preceed||precede
 precendence||precedence
 precission||precision
+predicition||prediction
 preemptable||preemptible
 prefered||preferred
 prefferably||preferably
@@ -1289,6 +1312,7 @@ querrying||querying
 queus||queues
 randomally||randomly
 raoming||roaming
+readyness||readiness
 reasearcher||researcher
 reasearchers||researchers
 reasearch||research
@@ -1305,8 +1329,10 @@ recieves||receives
 recieving||receiving
 recogniced||recognised
 recognizeable||recognizable
+recompte||recompute
 recommanded||recommended
 recyle||recycle
+redect||reject
 redircet||redirect
 redirectrion||redirection
 redundacy||redundancy
@@ -1314,6 +1340,7 @@ reename||rename
 refcounf||refcount
 refence||reference
 refered||referred
+referencce||reference
 referenace||reference
 refererence||reference
 refering||referring
@@ -1348,11 +1375,13 @@ replys||replies
 reponse||response
 representaion||representation
 repsonse||response
+reqested||requested
 reqeust||request
 reqister||register
 requed||requeued
 requestied||requested
 requiere||require
+requieres||requires
 requirment||requirement
 requred||required
 requried||required
@@ -1440,6 +1469,7 @@ sequencial||sequential
 serivce||service
 serveral||several
 servive||service
+sesion||session
 setts||sets
 settting||setting
 shapshot||snapshot
@@ -1602,11 +1632,13 @@ trys||tries
 thses||these
 tiggers||triggers
 tiggered||triggered
+tiggerring||triggering
 tipically||typically
 timeing||timing
 timming||timing
 timout||timeout
 tmis||this
+tolarance||tolerance
 toogle||toggle
 torerable||tolerable
 torlence||tolerance
@@ -1633,6 +1665,7 @@ trasfer||transfer
 trasmission||transmission
 trasmitter||transmitter
 treshold||threshold
+trigged||triggered
 triggerd||triggered
 trigerred||triggered
 trigerring||triggering
@@ -1648,6 +1681,7 @@ uknown||unknown
 usccess||success
 uncommited||uncommitted
 uncompatible||incompatible
+uncomressed||uncompressed
 unconditionaly||unconditionally
 undeflow||underflow
 undelying||underlying
@@ -1715,6 +1749,7 @@ utitity||utility
 utitlty||utility
 vaid||valid
 vaild||valid
+validationg||validating
 valide||valid
 variantions||variations
 varible||variable
@@ -1724,6 +1759,7 @@ verbse||verbose
 veify||verify
 verfication||verification
 veriosn||version
+versoin||version
 verisons||versions
 verison||version
 veritical||vertical
-- 
2.39.5



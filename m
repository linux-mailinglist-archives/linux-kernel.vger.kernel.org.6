Return-Path: <linux-kernel+bounces-561924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB4DA618A9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 296E5462F96
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34DE204C20;
	Fri, 14 Mar 2025 17:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="atPE9HXj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92893202C55
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 17:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741974806; cv=none; b=dxlgQQitGFdW1OgZZ8OotR7oeFMMNyq0ZwyPV4xqBMtOKBsmiSzNEJuyel2X9q/x+zjDWO64GMD5R8rtQFqf/KIDGJGBRz9N/0Hlfs1TzAFoeaZqsFiC8KCv+Msd1uCJy2VPf3EIYrvH2YcljUrjhaUOV5vY1LDI0qm/LHhQUsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741974806; c=relaxed/simple;
	bh=upqKoVusoCUr5x6/idcI9vYY8Ge9PfhUUDmqNXfdh8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nAA7asoZJrMEhLs2N+3FS6wBdxOSC2BMOtfjWcmvxDNVg1Wtn7vmdK4GQJ7Wowy2bOiDEFOrT1JW+rEa+Jks1ovxMc682WrSIxPViYZL5+sjwSLhJZj5KTTX1X2gbw5GJtn9Ac1cOYcaOtPQcwfSzECJsvnLTpNBH6TTGG1wLLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=atPE9HXj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741974803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bB6YFM9MmhDasWEynGvfo3R/5ogFVYWGX5dYTaSRdAk=;
	b=atPE9HXjhfXywcyXiydkf7CiMa8Og6HKYp8bXqybF2gxyveHHM4Fh0glF4HZOy7jBOyD0d
	O239BJF6/0U63vx1SpdSTfSu8vHVJp2L6rNeYvGYn44olWvGNc4EdKbvRxRQ79TyahYGLX
	zHinVMJtQeJODDunwosfSehGVR84Wco=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-QT7vdptgNIm5uDV61YbtIA-1; Fri,
 14 Mar 2025 13:53:18 -0400
X-MC-Unique: QT7vdptgNIm5uDV61YbtIA-1
X-Mimecast-MFC-AGG-ID: QT7vdptgNIm5uDV61YbtIA_1741974795
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C240187B6AB;
	Fri, 14 Mar 2025 17:53:12 +0000 (UTC)
Received: from redhat.com (unknown [10.96.134.26])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EA1341828A9F;
	Fri, 14 Mar 2025 17:53:10 +0000 (UTC)
From: "Herton R. Krzesinski" <herton@redhat.com>
To: x86@kernel.org
Cc: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	olichtne@redhat.com,
	atomasov@redhat.com,
	aokuliar@redhat.com
Subject: Performance issues in copy_user_generic() in x86_64
Date: Fri, 14 Mar 2025 14:53:08 -0300
Message-ID: <20250314175309.2263997-1-herton@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hello,

recently I have got two reports of performance loss in copy_user_generic()
after updates in user copy functions in x86_64, when benchmarking with iperf3.
I believe the write alignment to 8 bytes that was done through the old
ALIGN_DESTINATION macro was helping in some cases, and when it was removed the
performance drop can be noticed. Looks like this theory is corroborated by some
performance testing I did.

Please take a look at the following email with the patch if everything is sane.
I already did some testing as explained in the changelog of the patch. I used
the following scripts to run the testing, I just wrote them to get the job done
and get some results, so there is nothing fancy about them.

---- bench.sh
#!/bin/bash

dir=$1
mkdir -p $dir

for cpu in 19 21 23 none; do
	sync
	echo 3 > /proc/sys/vm/drop_caches
	cpu_opt=""
	if [ "$cpu" != "none" ]; then
		cpu_opt="taskset -c $cpu"
	fi
	$cpu_opt iperf3 -D -s -B 127.0.0.1 -p 12000
	perf stat -o $dir/stat.$cpu.txt taskset -c 17 iperf3 -c 127.0.0.1 -b 0/1000 -V -n 50G --repeating-payload -l 16384 -p 12000 --cport 12001 2>&1 > $dir/stat-$cpu.txt
	cat $dir/stat.$cpu.txt >> $dir/stat-$cpu.txt
	rm -f $dir/stat.$cpu.txt
	killall iperf3
done
----

---- stat.sh
#!/bin/bash

dir=$1
printf "            %4s  %13s %12s %12s %11s\n" "CPU" "RATE     " "SYS     " "TIME    " "sender-receiver"

for cpu in 19 21 23 none; do
	time=$(grep 'seconds time elapsed' $dir/stat-$cpu.txt | awk '{ print $1 }')
	sys=$(grep 'seconds sys' $dir/stat-$cpu.txt | awk '{ print $1 }')
	rate=$(grep ' sender' $dir/stat-$cpu.txt | awk '{ print $7 $8 }')
	cpuu=$(grep 'CPU Utilization' $dir/stat-$cpu.txt | awk '{ printf "%s-%s\n", $4, $7 }')

	printf "Server bind %4s: $rate $sys $time %s\n" $cpu $cpuu
done
----

Example of a test run:
nice -n -20 ./bench.sh align
./stat.sh align



Return-Path: <linux-kernel+bounces-577186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80028A7199D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91F423BF9D1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0484D1F540C;
	Wed, 26 Mar 2025 14:55:20 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554591F4173
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 14:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743000918; cv=none; b=OYaK7gRdBwIxWnAsNg2bCN4A/suLIx2RbONFOUyC2qjLjJKiQL0f/3bWYSYyesNp5L1YECyem/Dtb8jueJiPvLgScRqeks5DXbigi6QOLHpxmD1ETBntHG3FIa0n00sQSm6FZ20nAEF6NQR2hFEnuNW3+lRX1YABVzZQkY9vQQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743000918; c=relaxed/simple;
	bh=IrI/e9OiTfMrQ42Z1i3DNtNrpqZY4yoMiD8jn+nJSbU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=VmI561X6t46vsmY8R6lwx9ONw0tIgXQhpPmRzZe+ORP84HiSsj7z+DCtBihprDdVpgRLXdCZ9K95WwtdcDaPMcpqup+VgiE5j/AJeG6rDLoie0UGeRiPYnqVr70usjqUm+XOqIdvCQ/ogpiDxCFbLhUDNfhfX1NzbJ3WPNQoglA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406E5C4CEE2;
	Wed, 26 Mar 2025 14:55:18 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1txSAn-00000002kG4-0cMZ;
	Wed, 26 Mar 2025 10:56:05 -0400
Message-ID: <20250326145604.996254538@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 26 Mar 2025 10:55:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Luis Goncalves <lgoncalv@redhat.com>
Subject: [for-next][PATCH 8/9] rtla/tests: Test setting default options
References: <20250326145549.978154551@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Tomas Glozar <tglozar@redhat.com>

Add function to test engine to test with pre-set osnoise options, and
use it to test whether osnoise period (as an example) is set correctly.

The test works by pre-setting a high period of 10 minutes and stop on
threshold. Thus, it is easy to check whether rtla is properly resetting
the period to default: if it is, the test will complete on time, since
the first sample will overflow the threshold. If not, it will time out.

Cc: Luis Goncalves <lgoncalv@redhat.com>
Link: https://lore.kernel.org/20250320092500.101385-7-tglozar@redhat.com
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Reviewed-by: John Kacur <jkacur@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/tests/engine.sh | 26 ++++++++++++++++++++++++++
 tools/tracing/rtla/tests/osnoise.t |  6 ++++++
 2 files changed, 32 insertions(+)

diff --git a/tools/tracing/rtla/tests/engine.sh b/tools/tracing/rtla/tests/engine.sh
index 5db8aa4bc031..b1697b3e3f52 100644
--- a/tools/tracing/rtla/tests/engine.sh
+++ b/tools/tracing/rtla/tests/engine.sh
@@ -61,6 +61,32 @@ check() {
 	fi
 }
 
+check_with_osnoise_options() {
+	# Do the same as "check", but with pre-set osnoise options.
+	# Note: rtla should reset the osnoise options, this is used to test
+	# if it indeed does so.
+	# Save original arguments
+	arg1=$1
+	arg2=$2
+
+	# Apply osnoise options (if not dry run)
+	if [ -n "$TEST_COUNT" ]
+	then
+		[ "$NO_RESET_OSNOISE" == 1 ] || reset_osnoise
+		shift
+		while shift
+		do
+			[ "$1" == "" ] && continue
+			option=$(echo $1 | cut -d '=' -f 1)
+			value=$(echo $1 | cut -d '=' -f 2)
+			echo "option: $option, value: $value"
+			echo "$value" > "/sys/kernel/tracing/osnoise/$option" || return 1
+		done
+	fi
+
+	NO_RESET_OSNOISE=1 check "$arg1" "$arg2"
+}
+
 set_timeout() {
 	TIMEOUT="timeout -v -k 15s $1"
 }
diff --git a/tools/tracing/rtla/tests/osnoise.t b/tools/tracing/rtla/tests/osnoise.t
index 86596e547893..e5995c03c790 100644
--- a/tools/tracing/rtla/tests/osnoise.t
+++ b/tools/tracing/rtla/tests/osnoise.t
@@ -16,4 +16,10 @@ check "verify the  --trace param" \
 check "verify the --entries/-E param" \
 	"osnoise hist -P F:1 -c 0 -r 900000 -d 1M -b 10 -E 25"
 
+# Test setting default period by putting an absurdly high period
+# and stopping on threshold.
+# If default period is not set, this will time out.
+check_with_osnoise_options "apply default period" \
+	"osnoise hist -s 1" period_us=600000000
+
 test_end
-- 
2.47.2




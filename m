Return-Path: <linux-kernel+bounces-311681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 739DF968C12
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 18:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5E7A1C224C7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB96185B4C;
	Mon,  2 Sep 2024 16:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="RXXeuqAx"
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8622181AC8
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 16:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725294869; cv=none; b=pKtbY+44KckwTMXa7kEVxC0+dsfkPB7QdLMnyMJWJyZDdS/jYugWbJU2714gVA3p3qSwnOfyV2rNZxc9PiwFz5/WIgwui+MB1ZhhZBFXVnM7e/ayk9OO24Z8YQp9AqblZMVKuXN7hvBXiJSrj2fYBL/ZvhmJ3DgMJNfBxBU+h0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725294869; c=relaxed/simple;
	bh=5jFUTRcDwsdgM2AQVIAoOZ1Pjqai13CYe6ZSY5fIPKs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JU8Upq2QCsnyJ0MvK8zbmCN7kSBqTguOrVY1QS1NMeN9l/GHZ32UGHCUJsoWB2PBBlIvy9jboi2dW1E28sKKSX7BW+h1S9Eu7S1qMA3P0H5Ry4Jd+LswVbXk68MakXdEQG0spGp5lID2AsIfvdVj7mEoZJhcxiBN4+MHHifCVsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=RXXeuqAx; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1725294868; x=1756830868;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5jFUTRcDwsdgM2AQVIAoOZ1Pjqai13CYe6ZSY5fIPKs=;
  b=RXXeuqAxq+DT5vYOzGJLrO3CxW5aAgNw4PuZcNfseC2aacBZjNBNYQFt
   bkT6CT8EI4qMiOIs4ZJqgDR1EnsI3r+lYgdJFOGA8v0tqqEC+DUg04frR
   A51UdB5cvvZQgqIuYchdhuPBSQ25RpzdjBshX0NX2ipk0UNYKP0MTiSH5
   w=;
X-IronPort-AV: E=Sophos;i="6.10,196,1719878400"; 
   d="scan'208";a="755830880"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 16:34:21 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.17.79:34199]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.37.143:2525] with esmtp (Farcaster)
 id baa764ee-730a-4b0a-8c81-82279a5d2898; Mon, 2 Sep 2024 16:34:19 +0000 (UTC)
X-Farcaster-Flow-ID: baa764ee-730a-4b0a-8c81-82279a5d2898
Received: from EX19D007EUA001.ant.amazon.com (10.252.50.133) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 2 Sep 2024 16:34:19 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D007EUA001.ant.amazon.com (10.252.50.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 2 Sep 2024 16:34:18 +0000
Received: from dev-dsk-faresx-1b-27755bf1.eu-west-1.amazon.com (10.253.79.181)
 by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34
 via Frontend Transport; Mon, 2 Sep 2024 16:34:17 +0000
From: Fares Mehanna <faresx@amazon.de>
To: 
CC: <nh-open-source@amazon.com>, Fares Mehanna <faresx@amazon.de>,
	=?UTF-8?q?Jan=20H=20=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>, "Catalin
 Marinas" <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: trans_pgd: mark PTEs entries as valid to avoid dead kexec()
Date: Mon, 2 Sep 2024 16:33:08 +0000
Message-ID: <20240902163309.97113-1-faresx@amazon.de>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

VGhlIHJlYXNvbnMgZm9yIFBURXMgaW4gdGhlIGtlcm5lbCBkaXJlY3QgbWFwIHRvIGJlIG1hcmtl
ZCBpbnZhbGlkIGFyZSBub3QKbGltaXRlZCB0byBrZmVuY2UgLyBkZWJ1ZyBwYWdlYWxsb2MgbWFj
aGluZXJ5LiBJbiBwYXJ0aWN1bGFyLAptZW1mZF9zZWNyZXQoKSBhbHNvIHN0ZWFscyBwYWdlcyB3
aXRoIHNldF9kaXJlY3RfbWFwX2ludmFsaWRfbm9mbHVzaCgpLgoKV2hlbiBidWlsZGluZyB0aGUg
dHJhbnNpdGlvbmFsIHBhZ2UgdGFibGVzIGZvciBrZXhlYyBmcm9tIHRoZSBjdXJyZW50Cmtlcm5l
bCdzIHBhZ2UgdGFibGVzLCB0aG9zZSBwYWdlcyBuZWVkIHRvIGJlY29tZSByZWd1bGFyIHdyaXRh
YmxlIHBhZ2VzLApvdGhlcndpc2UsIGlmIHRoZSByZWxvY2F0aW9uIHBsYWNlcyBrZXhlYyBzZWdt
ZW50cyBvdmVyIHN1Y2ggcGFnZXMsIGEgZmF1bHQKd2lsbCBvY2N1ciBkdXJpbmcga2V4ZWMsIGxl
YWRpbmcgdG8gaG9zdCBnb2luZyBkYXJrIGR1cmluZyBrZXhlYy4KClRoaXMgcGF0Y2ggYWRkcmVz
c2VzIHRoZSBrZXhlYyBpc3N1ZSBieSBtYXJraW5nIGFueSBQVEUgYXMgdmFsaWQgaWYgaXQgaXMK
bm90IG5vbmUuIFdoaWxlIHRoaXMgZml4ZXMgdGhlIGtleGVjIGNyYXNoLCBpdCBkb2VzIG5vdCBh
ZGRyZXNzIHRoZQpzZWN1cml0eSBjb25jZXJuIHRoYXQgaWYgcHJvY2Vzc2VzIG93bmluZyBzZWNy
ZXQgbWVtb3J5IGFyZSBub3QgdGVybWluYXRlZApiZWZvcmUga2V4ZWMsIHRoZSBzZWNyZXQgY29u
dGVudCB3aWxsIGJlIG1hcHBlZCBpbiB0aGUgbmV3IGtlcm5lbCB3aXRob3V0CmJlaW5nIHNjcnVi
YmVkLgoKU3VnZ2VzdGVkLWJ5OiBKYW4gSC4gU2Now7ZuaGVyciA8anNjaG9lbmhAYW1hem9uLmRl
PgpTaWduZWQtb2ZmLWJ5OiBGYXJlcyBNZWhhbm5hIDxmYXJlc3hAYW1hem9uLmRlPgotLS0KIGFy
Y2gvYXJtNjQvbW0vdHJhbnNfcGdkLmMgfCA2ICsrKystLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L21tL3Ry
YW5zX3BnZC5jIGIvYXJjaC9hcm02NC9tbS90cmFuc19wZ2QuYwppbmRleCA1MTM5YTI4MTMwYzAu
LjBmN2I0ODRjYjJmZiAxMDA2NDQKLS0tIGEvYXJjaC9hcm02NC9tbS90cmFuc19wZ2QuYworKysg
Yi9hcmNoL2FybTY0L21tL3RyYW5zX3BnZC5jCkBAIC00MiwxNCArNDIsMTYgQEAgc3RhdGljIHZv
aWQgX2NvcHlfcHRlKHB0ZV90ICpkc3RfcHRlcCwgcHRlX3QgKnNyY19wdGVwLCB1bnNpZ25lZCBs
b25nIGFkZHIpCiAJCSAqIHRoZSB0ZW1wb3JhcnkgbWFwcGluZ3Mgd2UgdXNlIGR1cmluZyByZXN0
b3JlLgogCQkgKi8KIAkJX19zZXRfcHRlKGRzdF9wdGVwLCBwdGVfbWt3cml0ZV9ub3ZtYShwdGUp
KTsKLQl9IGVsc2UgaWYgKChkZWJ1Z19wYWdlYWxsb2NfZW5hYmxlZCgpIHx8Ci0JCSAgIGlzX2tm
ZW5jZV9hZGRyZXNzKCh2b2lkICopYWRkcikpICYmICFwdGVfbm9uZShwdGUpKSB7CisJfSBlbHNl
IGlmICghcHRlX25vbmUocHRlKSkgewogCQkvKgogCQkgKiBkZWJ1Z19wYWdlYWxsb2Mgd2lsbCBy
ZW1vdmVkIHRoZSBQVEVfVkFMSUQgYml0IGlmCiAJCSAqIHRoZSBwYWdlIGlzbid0IGluIHVzZSBi
eSB0aGUgcmVzdW1lIGtlcm5lbC4gSXQgbWF5IGhhdmUKIAkJICogYmVlbiBpbiB1c2UgYnkgdGhl
IG9yaWdpbmFsIGtlcm5lbCwgaW4gd2hpY2ggY2FzZSB3ZSBuZWVkCiAJCSAqIHRvIHB1dCBpdCBi
YWNrIGluIG91ciBjb3B5IHRvIGRvIHRoZSByZXN0b3JlLgogCQkgKgorCQkgKiBPdGhlciBjYXNl
cyBpbmNsdWRlIGtmZW5jZSAvIHZtYWxsb2MgLyBtZW1mZF9zZWNyZXQgd2hpY2gKKwkJICogbWF5
IGNhbGwgYHNldF9kaXJlY3RfbWFwX2ludmFsaWRfbm9mbHVzaCgpYC4KKwkJICoKIAkJICogQmVm
b3JlIG1hcmtpbmcgdGhpcyBlbnRyeSB2YWxpZCwgY2hlY2sgdGhlIHBmbiBzaG91bGQKIAkJICog
YmUgbWFwcGVkLgogCQkgKi8KLS0gCjIuNDAuMQoKCgoKQW1hem9uIFdlYiBTZXJ2aWNlcyBEZXZl
bG9wbWVudCBDZW50ZXIgR2VybWFueSBHbWJICktyYXVzZW5zdHIuIDM4CjEwMTE3IEJlcmxpbgpH
ZXNjaGFlZnRzZnVlaHJ1bmc6IENocmlzdGlhbiBTY2hsYWVnZXIsIEpvbmF0aGFuIFdlaXNzCkVp
bmdldHJhZ2VuIGFtIEFtdHNnZXJpY2h0IENoYXJsb3R0ZW5idXJnIHVudGVyIEhSQiAyNTc3NjQg
QgpTaXR6OiBCZXJsaW4KVXN0LUlEOiBERSAzNjUgNTM4IDU5Nwo=



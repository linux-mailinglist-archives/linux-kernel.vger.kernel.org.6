Return-Path: <linux-kernel+bounces-190435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 306258CFE31
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8890BB2116A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B376413B585;
	Mon, 27 May 2024 10:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5ZKdahh"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4135979E1;
	Mon, 27 May 2024 10:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716806221; cv=none; b=bKkYgbMpYIAQt4MTyEHqGGPP+Twk9e+TXgRUkGwpWCn6+mN/5l0nX8ot/0Arz7BfyDnaxN1RfMDOSJ/HTVZS3ongjjPyMjXyLzbKx6yR2tmce44uR9IZZjVVxnECDkuVBm5b7B3GXUxnw9NJkL75YoARZsk06g/OG7TTGwen8fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716806221; c=relaxed/simple;
	bh=hHRqAUoBRH82pJuymk4l5g2SstMzMc4ea1ZkfNBzjC8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ALuEZf0UYE2ISWeLxCH05cMQlCq8ryT0IaABTMFojoZ4f6x2YCOCOU9+81qC/O4uO7EO51hzpGmpbiN+f7GrZetcwrHVR8mt4hnneWJ9giH8IkmbLigUZ9Y5R5Om+JEJsSTyQVQCaOY1Rm7LZKZYOSTw5hkzfPLymsWvOHbyJco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5ZKdahh; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-24542b8607fso4871355fac.1;
        Mon, 27 May 2024 03:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716806219; x=1717411019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kKFpB0RxiHeU9h9LrzBPuEHdR23O3Fp1vgl2G/bmm/Y=;
        b=f5ZKdahh9JlMPZfgjZ+vtvctBd9++TGbv+0FVSdafq0EJbmjpb/t1QLilKEwDL6KnK
         hsTFvOxdNV1DOm+V6UXx0R7FARLZzBNNZ+XCIFUcq/IZT4RnD1sebxMFMrKVuxeQrTtB
         9A9gY1OLb1OBI+R4V2BY9N030lkflz2YF31lg8t7Q3FksTJgJXzykJPikG4pJcgV3l/X
         I8VFi1XK+OQSqR7qGpMv022B9ddD6dn16KNBwXC3uT2ViVbf4WB09SjMQwS+KI2LqlNg
         LkNSQ5RiPAfCZ9/rfvjEV5dDj192MnQvTn0rHOfqJ0FaEzByrCpaFQFFyAolzWFTInz9
         pnkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716806219; x=1717411019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kKFpB0RxiHeU9h9LrzBPuEHdR23O3Fp1vgl2G/bmm/Y=;
        b=CyvPtXHUZi042JMA45ZIsTw2euBYD5ufigUbEd9KuHPAUj0oOMIWAqKNyWC+JwkJPs
         UDk63Su/t4dXSee8qwNKxci4Kk184vI+SHj43Ft4+TaFItJkkWC9Xovm/ld2Ego28uXO
         dNTPTLsG2LAiV2f154rik7j1rUHyVJraNGsjbyOEm2AMMiv5hAAhz03d+Lke3cqsEjeq
         5yPZKR2W70xVt2gmetftGgr13t9j8G7s8aYlV5hKm41La4uGwoa5emAcKlP+fRgnajVD
         D8CvkhUyp/jOfuGF/8JvxRH/r1U8eR+KrqRXMZhTYgObyBWGqjSMWTxx35RT5QJg6JdX
         QGoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZXIhtYF9rg7mPrcohYnHVwZ7UhPf5EAOFagNH1dUA8PrcbJWca+DoOCjva0Eyeacive18Zjo2jDCJHfGlZSlQVGlpem+toCD4dDqXWpiy0YmDThw4D8mMD891ZPti4H5NhgpcSlOjo6T5VmX49qPwOht/hbWlllqJuiajvRsdv9WX
X-Gm-Message-State: AOJu0YzcBDUwNdqMzRWi+I6CH2KrKD8p7Fy3hypZtpEVL2MSJsOx3ADx
	sKrTfQfsK24YKV8J9Xc8SP/OF4l+MvtNVIAP52a8NO0bSPnpq4Ldu8KHUhYE0rY=
X-Google-Smtp-Source: AGHT+IFM3r0yjsYplvaxmfygwWUpTBUyxDnVMyuZSf+5aSVRHTWbCemFcPQI11t1+3UREEmjclXR3g==
X-Received: by 2002:a05:6870:c110:b0:24f:d1f3:a87c with SMTP id 586e51a60fabf-24fd1f3a8edmr5713633fac.10.1716806219202;
        Mon, 27 May 2024 03:36:59 -0700 (PDT)
Received: from paran-QEMU-Virtual-Machine.. ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f93d308732sm4354512b3a.101.2024.05.27.03.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 03:36:58 -0700 (PDT)
From: yskelg@gmail.com
To: Jonathan Corbet <corbet@lwn.net>
Cc: skhan@linuxfoundation.org,
	Jinwoo Park <pmnxis@gmail.com>,
	Austin Kim <austindh.kim@gmail.com>,
	shjy180909@gmail.com,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Yunseong Kim <yskelg@gmail.com>
Subject: [PATCH v2] Documentation: security-bugs Korean translation
Date: Mon, 27 May 2024 19:36:35 +0900
Message-Id: <20240527103634.31019-1-yskelg@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Yunseong Kim <yskelg@gmail.com>

This is a Documentation/process/security-bugs korean version.

Signed-off-by: Yunseong Kim <yskelg@gmail.com>
---
 .../ko_KR/process/security-bugs.rst           | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 Documentation/translations/ko_KR/process/security-bugs.rst

diff --git a/Documentation/translations/ko_KR/process/security-bugs.rst b/Documentation/translations/ko_KR/process/security-bugs.rst
new file mode 100644
index 000000000000..b8f16fe846ac
--- /dev/null
+++ b/Documentation/translations/ko_KR/process/security-bugs.rst
@@ -0,0 +1,96 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+:Original: Documentation/process/security-bugs.rst
+:Translator: Yunseong Kim <yskelg@gmail.com>
+
+보안 버그
+=========
+
+Linux 커널 개발자는 보안을 매우 중요하게 생각합니다.
+따라서 보안 버그를 발견하면 가능한 한 빨리 수정하고 공개할 수 있도록
+알려주시기 바랍니다. 보안 버그를 Linux 커널 보안 팀에 신고해 주세요.
+
+제보하기
+--------
+
+Linux 커널 보안팀은 <security@kernel.org> 이메일로 연락할 수 있습니다.
+버그 신고를 확인하고 수정 사항을 개발 및 릴리스하는 데 도움을 줄 보안 담당자의
+비공개 목록입니다. 이미 수정 사항이 있는 경우 신고에 포함하면 처리 속도가
+상당히 빨라질 수 있습니다. 보안팀이 보안 취약점을 파악하고 수정하기 위해
+영역 관리자의 도움을 추가로 받을 수도 있습니다.
+
+모든 버그가 그렇듯이 더 많은 정보를 제공할수록 진단과 수정이 더 쉬워집니다.
+어떤 정보가 도움이 될지 잘 모르겠다면
+'Documentation/admin-guide/reporting-issues.rst'에
+나와있는 문제 신고하기 절차를 검토해 주세요. 모든 보안 취약점 공격 코드는
+매우 유용하며 이미 공개되어 있지 않은 한 신고자의 동의 없이 공개되지 않습니다.
+
+가능한 경우 첨부 파일 없이 일반 텍스트 이메일을 보내주세요.
+첨부 파일에 모든 세부 사항이 숨겨져 있으면 복잡한 문제에 대해 맥락에 맞는
+토론을 하기가 훨씬 더 어렵습니다. (아직 패치가 없는 경우라도) :doc:`일반적인
+패치 제출<../../../process/submitting-patches>`과 마찬가지로 문제와 영향을
+설명하고, 재현 단계를 나열하고, 제안된 수정 사항을 모두 일반 텍스트로
+작성하세요.
+
+공개 및 엠바고 정보
+-------------------
+
+보안 목록은 공개 채널이 아닙니다. 이에 대해서는 아래의 조정 사항을 참조하세요.
+강력한 수정이 개발되면 릴리스 프로세스가 시작됩니다. 공개적으로 알려진 버그에
+대한 수정 사항은 즉시 릴리스됩니다.
+
+공개적으로 알려지지 않은 버그에 대한 수정 사항이 제공되는 즉시 공개하는 것을
+선호하지만, 신고자 또는 영향을 받는 당사자의 요청에 따라 공개 프로세스
+시작일로부터 최대 7일 동안 연기될 수 있으며, 버그의 중요도에 따라 시간이 더
+필요하다는 데 동의하는 경우 예외적으로 14일까지 연장될 수 있습니다.
+수정 사항 공개를 연기할 수 있는 유일한 유효한 이유는 릴리스 조율이 필요한 QA
+및 대규모 롤아웃의 복잡한 실행 계획을 수용하기 위해서입니다.
+
+엠바고된 정보는 수정 개발을 위해 신뢰할 수 있는 개인과 공유할 수 있지만,
+신고자의 허가 없이 수정 사항과 함께 또는 다른 공개 채널에 게시할 수 없습니다.
+여기에는 원래의 버그 보고서와 후속 논의(있는 경우), 보안 취약점 공격 코드,
+CVE 정보 또는 신고자의 신원이 포함되지만 이에 국한되지 않습니다.
+
+다시 말해, 저희의 유일한 관심사는 버그 수정입니다. 보안 목록에 제출된 기타
+모든 정보와 보고에 대한 후속 논의는 엠바고가 해제된 후에도 영구적으로 기밀로
+취급됩니다.
+
+다른 그룹과의 협력
+------------------
+
+커널 보안팀은 버그 수정에만 집중하는 반면, 다른 그룹은 배포판의 문제를
+해결하고 운영 체제 공급업체 간의 공개를 조율하는 데 중점을 둡니다.
+조율은 일반적으로 "리눅스 배포판" 메일링 리스트에서 처리하고 공개는
+공공의 "oss-security" 메일링 리스트에서 처리하며, 이 둘은 서로 밀접하게
+관련되어 있으며 리눅스 배포판 위키에 제시되어 있습니다:
+<https://oss-security.openwall.org/wiki/mailing-lists/distros>
+
+세 가지 목록들이 추구하는 목표가 다르기 때문에 각각의 정책과 규칙이 다르다는
+점에 유의하세요. 커널 보안 팀과 다른 팀 간의 조율이 어려운 이유는
+커널 보안 팀의 경우 간혹 엠바고(최대 허용 일수에 따라)는 수정이 가능한
+시점부터 시작하지만, "리눅스 배포판"의 경우 수정 가능 여부와 관계없이 초기
+게시물부터 목록에 올라오기 때문입니다.
+
+따라서 커널 보안팀은 잠재적인 보안 문제를 신고하는 경우 해당 코드의
+메인테이너가 수정 사항을 수락하고 위의 배포판 위키 페이지를 읽었으며
+"리눅스 배포판" 메일링 리스트에 연락하는 것이 자신과 커널 커뮤니티에 부과되는
+요구 사항임을 완벽히 이해할 때까지 "리눅스 배포판"에 연락하지 않을 것을
+강력히 권장합니다. 이는 또한 일반적으로 수락된 수정 사항이 아직 병합되지 않은
+상태에서 조정을 위한 경우를 제외하고는 두 목록을 한 번에 참조하는 것이
+합리적이지 않다는 것을 의미합니다. 즉, 수정 사항이 수락될 때까지는
+"리눅스 배포판"을 메일에 참조하지 말고, 병합된 후에는 커널 보안 팀을 메일에
+참조하지 마세요.
+
+CVE 할당
+--------
+
+보안팀은 불필요하게 프로세스를 복잡하게 만들고 버그 처리를 지연시킬 수
+있으므로 보고나 수정에 대해 CVE를 할당하지 않으며, 이를 요구하지도 않습니다.
+보고자가 확인된 문제에 대해 CVE 식별자를 할당받고자 하는 경우 :doc:`커널 CVE
+할당팀<../../../process/cve>`에 연락하여 할당받을 수 있습니다.
+
+비공개 계약서
+-------------
+
+Linux 커널 보안 팀은 공식적인 기관이 아니므로 기밀 유지 계약을 체결할 수
+없습니다.
-- 
2.34.1



Return-Path: <linux-kernel+bounces-214377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D3D90836C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 07:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D642B1F232A5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 05:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD95147C90;
	Fri, 14 Jun 2024 05:55:01 +0000 (UTC)
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15C1145B34
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 05:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718344500; cv=none; b=twUujrH1KtYQ+vKGRPFYmbnc5jzRieC/Wr4wwokoBcc7lbh2GZmOajht80IKww8k1vs3qUw9SKE+kBbrORVEFhvgSNApRyuiQLRAVF6hF71yh+lrrpWYcJcXjUKGQNEOAu9IfHDMsaAX/h5uhRz4Yr61fdb84toAcUkOgMmWmwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718344500; c=relaxed/simple;
	bh=fVCy6/dkF7HT91z7sabukVEP02eEuNJGU6rMT2irjBo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P6ljGTAMnstnRTYC2nMQMeUuDR3ARv5J+75plC6/qk27vDazdcMnEfS13WwN8hI+GYvy1HraQ9C64C+a8Aqrk96/RBw91K0zM1viA6ror41cI4js6BI4aL+IxbJ8X7K+ViQt/oFrGskW7IMKF2jousQyZcJeU+2WWvcIY9ZJTkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app2 (Coremail) with SMTP id HwEQrAA3aMTr2mtmPKtzAQ--.33516S2;
	Fri, 14 Jun 2024 13:53:47 +0800 (CST)
Received: from localhost.localdomain (unknown [10.12.164.29])
	by gateway (Coremail) with SMTP id _____wCnMN_k2mtmS_QkAA--.8520S2;
	Fri, 14 Jun 2024 13:53:46 +0800 (CST)
From: Dongliang Mu <dzm91@hust.edu.cn>
To: Dongliang Mu <dzm91@hust.edu.cn>,
	Alex Shi <alexs@kernel.org>,
	Cheng Ziqiu <chengziqiu@hust.edu.cn>,
	Yanteng Si <siyanteng@loongson.cn>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] scripts: fix most issues reported by pylint
Date: Fri, 14 Jun 2024 13:53:20 +0800
Message-Id: <20240614055328.778041-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HwEQrAA3aMTr2mtmPKtzAQ--.33516S2
Authentication-Results: app2; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoW3AF1DAr47tF4kKFWruF4fAFb_yoWxGF15p3
	45CFWIyrs8JrWUtr1xGw4UZFy3Ar9rJrWjqryqq3s7ArnrK3409FW2y34SvrW7WFyrXa43
	GFWYyr1jqF1j9aDanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQIb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vE
	x4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAaw2AFwI0_Jr
	v_JF1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF
	0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26r
	4UJVWxJr1lYx0E74AGY7Cv6cx26r4fZr1UJr1lYx0Ec7CjxVAajcxG14v26F4j6r4UJwAm
	72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42
	xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8uFyUJr1UMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUYSoGJUUUUU==
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/

Pylint reports many coding style issues of scripts/checktransupdate.py

This patch fixes most issues with the following contents:
- add or revise comments for all functions
- use format string suggested by python

Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 scripts/checktransupdate.py | 55 ++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 31 deletions(-)

diff --git a/scripts/checktransupdate.py b/scripts/checktransupdate.py
index 5a0fc99e3f93..70a5dab1a17b 100755
--- a/scripts/checktransupdate.py
+++ b/scripts/checktransupdate.py
@@ -4,19 +4,9 @@
 """
 This script helps track the translation status of the documentation
 in different locales, e.g., zh_CN. More specially, it uses `git log`
-commit to find the latest english commit from the translation commit
-(order by author date) and the latest english commits from HEAD. If
+command to find the latest English commit from the translation commit
+(order by author date) and the latest English commits from HEAD. If
 differences occur, report the file and commits that need to be updated.
-
-The usage is as follows:
-- ./scripts/checktransupdate.py -l zh_CN
-This will print all the files that need to be updated in the zh_CN locale.
-- ./scripts/checktransupdate.py Documentation/translations/zh_CN/dev-tools/testing-overview.rst
-This will only print the status of the specified file.
-
-The output is something like:
-Documentation/translations/zh_CN/dev-tools/testing-overview.rst (1 commits)
-commit 42fb9cfd5b18 ("Documentation: dev-tools: Add link to RV docs")
 """
 
 import os
@@ -29,12 +19,14 @@ flag_debug = False
 
 
 def dprint(*args, **kwargs):
+    """Print debug information if the debug flag is set"""
     if flag_debug:
         print("[DEBUG] ", end="")
         print(*args, **kwargs)
 
 
 def get_origin_path(file_path):
+    """Get the origin path from the translation path"""
     paths = file_path.split("/")
     tidx = paths.index("translations")
     opaths = paths[:tidx]
@@ -43,9 +35,8 @@ def get_origin_path(file_path):
 
 
 def get_latest_commit_from(file_path, commit):
-    command = "git log --pretty=format:%H%n%aD%n%cD%n%n%B {} -1 -- {}".format(
-        commit, file_path
-    )
+    """Get the latest commit from the specified commit for the specified file"""
+    command = f"git log --pretty=format:%H%n%aD%n%cD%n%n%B {commit} -1 -- {file_path}"
     dprint(command)
     pipe = os.popen(command)
     result = pipe.read()
@@ -53,7 +44,7 @@ def get_latest_commit_from(file_path, commit):
     if len(result) <= 1:
         return None
 
-    dprint("Result: {}".format(result[0]))
+    dprint(f"Result: {result[0]}")
 
     return {
         "hash": result[0],
@@ -64,16 +55,18 @@ def get_latest_commit_from(file_path, commit):
 
 
 def get_origin_from_trans(origin_path, t_from_head):
+    """Get the latest origin commit from the translation commit"""
     o_from_t = get_latest_commit_from(origin_path, t_from_head["hash"])
     while o_from_t is not None and o_from_t["author_date"] > t_from_head["author_date"]:
         o_from_t = get_latest_commit_from(origin_path, o_from_t["hash"] + "^")
     if o_from_t is not None:
-        dprint("tracked origin commit id: {}".format(o_from_t["hash"]))
+        dprint(f"tracked origin commit id: {o_from_t['hash']}")
     return o_from_t
 
 
 def get_commits_count_between(opath, commit1, commit2):
-    command = "git log --pretty=format:%H {}...{} -- {}".format(commit1, commit2, opath)
+    """Get the commits count between two commits for the specified file"""
+    command = f"git log --pretty=format:%H {commit1}...{commit2} -- {opath}"
     dprint(command)
     pipe = os.popen(command)
     result = pipe.read().split("\n")
@@ -83,50 +76,52 @@ def get_commits_count_between(opath, commit1, commit2):
 
 
 def pretty_output(commit):
-    command = "git log --pretty='format:%h (\"%s\")' -1 {}".format(commit)
+    """Pretty print the commit message"""
+    command = f"git log --pretty='format:%h (\"%s\")' -1 {commit}"
     dprint(command)
     pipe = os.popen(command)
     return pipe.read()
 
 
 def check_per_file(file_path):
+    """Check the translation status for the specified file"""
     opath = get_origin_path(file_path)
 
     if not os.path.isfile(opath):
-        dprint("Error: Cannot find the origin path for {}".format(file_path))
+        dprint(f"Error: Cannot find the origin path for {file_path}")
         return
 
     o_from_head = get_latest_commit_from(opath, "HEAD")
     t_from_head = get_latest_commit_from(file_path, "HEAD")
 
     if o_from_head is None or t_from_head is None:
-        print("Error: Cannot find the latest commit for {}".format(file_path))
+        print(f"Error: Cannot find the latest commit for {file_path}")
         return
 
     o_from_t = get_origin_from_trans(opath, t_from_head)
 
     if o_from_t is None:
-        print("Error: Cannot find the latest origin commit for {}".format(file_path))
+        print(f"Error: Cannot find the latest origin commit for {file_path}")
         return
 
     if o_from_head["hash"] == o_from_t["hash"]:
         if flag_p_uf:
-            print("No update needed for {}".format(file_path))
-        return
+            print(f"No update needed for {file_path}")
     else:
-        print("{}".format(file_path), end="\t")
+        print(f"{file_path}", end="\t")
         commits = get_commits_count_between(
             opath, o_from_t["hash"], o_from_head["hash"]
         )
-        print("({} commits)".format(len(commits)))
+        print(f"({len(commits)} commits)")
         if flag_p_c:
             for commit in commits:
                 msg = pretty_output(commit)
                 if "Merge tag" not in msg:
-                    print("commit", msg)
+                    print(f"commit {msg}")
 
 
 def main():
+    """Main function of the script"""
     script_path = os.path.dirname(os.path.abspath(__file__))
     linux_path = os.path.join(script_path, "..")
 
@@ -173,9 +168,7 @@ def main():
         if args.locale is not None:
             files = (
                 os.popen(
-                    "find {}/Documentation/translations/{} -type f".format(
-                        linux_path, args.locale
-                    )
+                    f"find {linux_path}/Documentation/translations/{args.locale} -type f"
                 )
                 .read()
                 .split("\n")
@@ -183,7 +176,7 @@ def main():
         else:
             files = (
                 os.popen(
-                    "find {}/Documentation/translations -type f".format(linux_path)
+                    f"find {linux_path}/Documentation/translations -type f"
                 )
                 .read()
                 .split("\n")
-- 
2.39.2


